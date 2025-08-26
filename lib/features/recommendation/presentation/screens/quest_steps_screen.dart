import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/recommendation/presentation/screens/tutorial_completion_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/features/missions/infrastructure/providers/mission_providers.dart';
import 'package:booquest/features/missions/application/states/mission_state.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/features/sidejob/infrastructure/sidejob_providers.dart';


class QuestStepsScreen extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>>? missionSteps;
  final int? selectedSideJobId; 
  final List<Map<String, dynamic>>? subQuests; // 부퀘스트 데이터
  final String? sideJobTitle; // 부업 제목
  final String? sideJobDesignNotes; // 부업 설명
  
  const QuestStepsScreen({
    super.key, 
    this.missionSteps,
    this.selectedSideJobId,
    this.subQuests, // 부퀘스트 데이터
    this.sideJobTitle,
    this.sideJobDesignNotes,
  });

  @override
  ConsumerState<QuestStepsScreen> createState() => _QuestStepsScreenState();
}

class _QuestStepsScreenState extends ConsumerState<QuestStepsScreen> {
  bool _isSubQuestExpanded = true; // 부퀘스트 펼침/접힘 상태
  List<Map<String, dynamic>>? _subQuests; // 부퀘스트 로컬 상태
  bool _isSubQuestLoading = false; // 부퀘스트 로딩 상태 

  @override
  void initState() {
    super.initState();
    _subQuests = widget.subQuests;
    
    if (widget.selectedSideJobId != null && widget.missionSteps == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(missionNotifierProvider.notifier).getMissionsBySideJobId(widget.selectedSideJobId!);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final missionState = ref.watch(missionNotifierProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        _buildTopRow(context),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 20),
                        _buildMainQuestSection(missionState),
                        const SizedBox(height: 50), 
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(context),
              ],
            ),
          ),
          if (_isSubQuestLoading || missionState.maybeWhen(loading: () => true, orElse: () => false))
            const AILoadingOverlay(
              title: 'AI가 미션을 불러오고 있어요...',
              subtitle: '잠시만 기다려주세요',
            ),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => _handleBack(),
        ),
        const Expanded(
          child: Center(child: Text('메인 퀘스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  void _handleBack() {
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const SideJobRecommendationsScreen(recommendations: []),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '메인 퀘스트 생성 완료',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '이렇게 진행하면 될까요?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainQuestSection(MissionState missionState) {
    return missionState.when(
      initial: () => _buildEmptyState(),
      loading: () => const SizedBox.shrink(), // 로딩은 오버레이로 처리
      success: (steps) {
        if (steps.isEmpty) {
          return _buildEmptyState();
        }
        
        // 부퀘스트 데이터는 missionSteps에서 직접 추출
        if (steps.isNotEmpty) {
          final firstMission = steps.first;
          if (firstMission.missionSteps != null && firstMission.missionSteps!.isNotEmpty) {
            // seq 순서대로 정렬하여 부퀘스트 리스트에 설정
            final sortedSteps = List<Map<String, dynamic>>.from(firstMission.missionSteps!);
            sortedSteps.sort((a, b) => (a['seq'] ?? 0).compareTo(b['seq'] ?? 0));
            
            setState(() {
              _subQuests = sortedSteps.map((step) => {
                'id': step['id'],
                'title': step['title'],
                'seq': step['seq'],
                'status': step['status'],
                'detail': step['detail'],
              }).toList();
            });
          }
        }
        
        return Column(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              if (i > 0) const SizedBox(height: 16), // 카드 간 간격을 16으로 증가
              _buildMainQuestListItem(
                steps[i].title,
                '${steps[i].order}단계',
                steps[i].designNotes,
                isFirstCard: i == 0, // 첫 번째 카드에만 부퀘스트 표시
              ),
            ],
          ],
        );
      },
      failure: (failure) => _buildErrorState(failure.userMessage),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '미션 데이터가 없습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '부업을 다시 선택해주세요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            '오류가 발생했습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 부퀘스트 섹션 위젯
  Widget _buildSubQuestSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSubQuestExpanded = !_isSubQuestExpanded;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '부 퀘스트',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.orange,
                ),
                const Spacer(),
                const Text(
                  '(0/5)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: _isSubQuestExpanded ? 0.0 : 0.5, // 180도 회전
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isSubQuestExpanded ? null : 0,
              child: _isSubQuestExpanded 
                ? _buildSubQuestList()
                : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  /// 부퀘스트 목록 위젯
  Widget _buildSubQuestList() {
    if (_subQuests == null || _subQuests!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '부퀘스트가 없습니다',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    // seq 순서대로 정렬
    final sortedSubQuests = List<Map<String, dynamic>>.from(_subQuests!);
    sortedSubQuests.sort((a, b) => (a['seq'] ?? 0).compareTo(b['seq'] ?? 0));

    return Column(
      children: [
        const SizedBox(height: 16),
        for (int i = 0; i < sortedSubQuests.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _buildSubQuestItem(sortedSubQuests[i]['title'] ?? '제목 없음'),
        ],
      ],
    );
  }

  /// 부퀘스트 아이템 위젯
  Widget _buildSubQuestItem(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildMainQuestListItem(String title, String difficulty, String description, {bool isFirstCard = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E7E7),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  '메인 퀘스트',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E7E7),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  difficulty,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, size: 24, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 첫 번째 카드에만 부퀘스트 섹션 추가
          if (isFirstCard) ...[
            const SizedBox(height: 20),
            _buildSubQuestSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () async {
              // 사용자 부업 선택 API 호출
              if (widget.selectedSideJobId != null) {
                await ref.read(sideJobNotifierProvider.notifier).selectUserSideJob(widget.selectedSideJobId!);
                
                // API 응답 확인
                final sideJobState = ref.read(sideJobNotifierProvider);
                final isSuccess = sideJobState.maybeWhen(
                  userSideJobSelected: (_) => true,
                  orElse: () => false,
                );
                
                if (!isSuccess) {
                  // API 실패 시 에러 메시지 표시
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('부업 선택에 실패했습니다. 다시 시도해주세요.')),
                    );
                  }
                  return;
                }
              }
              
              // 온보딩 완료 상태로 설정 
              await _markOnboardingCompleted();
              
              // 다음 화면으로 이동
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TutorialCompletionScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonActive,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('다음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  /// 온보딩 완료 상태 설정
  Future<void> _markOnboardingCompleted() async {
    try {
      // LocalStorageService: 온보딩 완료 상태 설정
      final storage = await LocalStorageService.getInstance();
      await storage.setOnboardingCompleted(true);
      
      // OnboardingStorageService: 현재 온보딩 단계 정보 삭제
      final onboardingStorage = await OnboardingStorageService.getInstance();
      await onboardingStorage.removeCurrentStep();
      
      print('✅ 온보딩 완료 상태 업데이트 완료');
    } catch (error) {
      print('❌ 온보딩 완료 상태 업데이트 실패: $error');
    }
  }
}


