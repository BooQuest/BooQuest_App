import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/recommendation/presentation/screens/tutorial_completion_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';

class QuestStepsScreen extends StatefulWidget {
  const QuestStepsScreen({super.key});

  @override
  State<QuestStepsScreen> createState() => _QuestStepsScreenState();
}

class _QuestStepsScreenState extends State<QuestStepsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                    _buildTabs(),
                    const SizedBox(height: 20),
                    _buildTabContent(),
                    const SizedBox(height: 50), // 하단 여백 추가
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Expanded(
          child: Center(child: Text('메인/부 퀘스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
        ),
        const SizedBox(width: 40),
      ],
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
                '메인/부 퀘스트 생성 완료',
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
        const SizedBox(width: 12),
        SizedBox(
          width: 39,
          height: 39,
          child: SvgPicture.asset(
            'assets/images/characters/basic_icon_1.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _tabController.animateTo(0);
          },
          child: Container(
            padding: const EdgeInsets.only(right: 32),
            child: Text(
              '메인 퀘스트',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _currentTabIndex == 0 
                    ? AppColors.textPrimary 
                    : AppColors.textPrimary.withOpacity(0.3),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _tabController.animateTo(1);
          },
          child: Text(
            '부 퀘스트',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _currentTabIndex == 1 
                  ? AppColors.textPrimary 
                  : AppColors.textPrimary.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    return IndexedStack(
      index: _currentTabIndex,
      children: [
        _buildMainQuestSection(),
        _buildSubQuestSection(),
      ],
    );
  }

  Widget _buildMainQuestSection() {
    return Column(
      children: [
        _buildMainQuestListItem('키워드 & 콘텐츠 전략 설계', '매우 쉬움'),
        const SizedBox(height: 12),
        _buildMainQuestListItem('키워드 & 콘텐츠 전략 설계', '매우 쉬움'),
      ],
    );
  }

  Widget _buildMainQuestListItem(String title, String difficulty) {
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
                  '1단계',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                difficulty,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
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
                      '메인 퀘스트에 대한 간단 설명 문구',
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
        ],
      ),
    );
  }

  Widget _buildSubQuestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 박스 (1단계 메인 퀘스트와 동일한 내용)
        Container(
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
                      '1단계',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '매우 쉬움',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.landscape, size: 20, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'SNS 계정 설정 & 브랜딩',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '메인 퀘스트에 대한 간단 설명 문구',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // 5개 부퀘스트 리스트
        _buildSubQuestItem(1, '부 퀘스트 이름'),
        const SizedBox(height: 8),
        _buildSubQuestItem(2, '부 퀘스트 이름'),
        const SizedBox(height: 8),
        _buildSubQuestItem(3, '부 퀘스트 이름'),
        const SizedBox(height: 8),
        _buildSubQuestItem(4, '부 퀘스트 이름'),
        const SizedBox(height: 8),
        _buildSubQuestItem(5, '부 퀘스트 이름'),
      ],
    );
  }

  Widget _buildSubQuestItem(int number, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          Text(
            '$number',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE0E0E0),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.landscape, size: 16, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Colors.black,
          ),
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


