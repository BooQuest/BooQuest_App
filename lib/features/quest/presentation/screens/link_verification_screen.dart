import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/quest/infrastructure/providers/bonus_proof_providers.dart';
import 'package:booquest/features/quest/application/states/bonus_proof_state.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';

/// 링크 인증 화면 - 부업 활동에 관한 링크를 간단히 남기기
class LinkVerificationScreen extends ConsumerStatefulWidget {
  final int stepId;
  final bool leveledUp;
  final int? currentLevel;
  
  const LinkVerificationScreen({
    super.key,
    required this.stepId,
    this.leveledUp = false,
    this.currentLevel,
  });

  @override
  ConsumerState<LinkVerificationScreen> createState() => _LinkVerificationScreenState();
}

class _LinkVerificationScreenState extends ConsumerState<LinkVerificationScreen> {
  int _currentIndex = 1; // Quest 탭이 선택된 상태
  final TextEditingController _linkController = TextEditingController();

  // 반응형을 위한 화면 크기 계산 (home_screen.dart와 동일한 구조)
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuestScreen(),
    const MyRecordScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Home 화면
            const HomeScreen(),
            // Quest 화면 (현재 화면)
            _buildLinkVerificationContent(),
            // MyRecord 화면
            const MyRecordScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  /// 링크 인증 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildLinkVerificationContent() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20, vertical: _isSmallScreen ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(),
                SizedBox(height: _isSmallScreen ? 32 : 40),
                _buildLinkInputField(),
                SizedBox(height: _isSmallScreen ? 12 : 16),
                _buildLinkExampleText(),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
          child: _buildVerifyButton(),
        ),
      ],
    );
  }

  /// 상단 바 구성 (quest_screen.dart와 동일한 구조)
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: _isSmallScreen ? 44 : 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 뒤로가기 버튼 (왼쪽)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: _isSmallScreen ? 36 : 40,
                height: _isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textPrimary,
                    size: _isSmallScreen ? 18 : 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            // 중앙 제목
            Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // 설정 버튼 (오른쪽)
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: _isSmallScreen ? 36 : 40,
                height: _isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () {
                    // TODO: 설정 화면으로 이동
                  },
                  icon: Icon(
                    Icons.settings,
                    color: AppColors.textPrimary,
                    size: _isSmallScreen ? 18 : 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 제목 섹션
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 메인 제목 (2줄로 분리)
        Text(
          '부업 활동에 관한 링크를',
          style: TextStyle(
            fontSize: _isSmallScreen ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        Text(
          '간단히 남겨주세요',
          style: TextStyle(
            fontSize: _isSmallScreen ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 20 : 24),
        // 부제목/설명
        Text(
          '외부 작업물에 관한 링크를 붙여 넣어주세요.',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// 링크 입력 필드
  Widget _buildLinkInputField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_isSmallScreen ? 14 : 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _linkController,
        onChanged: (value) {
          setState(() {
            // 텍스트 변경 시 UI 업데이트
          });
        },
        decoration: InputDecoration(
          hintText: 'http://',
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _isSmallScreen ? 14 : 16,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: _isSmallScreen ? 14 : 16,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// 링크 예시 텍스트
  Widget _buildLinkExampleText() {
    return Text(
      'ex.블로그 글, 티스토리 글, 포스타입, 노션 기록, 유튜브 영상 등',
      style: TextStyle(
        fontSize: _isSmallScreen ? 12 : 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
    );
  }

  /// 인증하기 버튼
  Widget _buildVerifyButton() {
    final isEnabled = _linkController.text.trim().isNotEmpty;
    
    return Container(
      width: double.infinity,
      height: _isSmallScreen ? 50 : 56,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
      ),
      child: TextButton(
        onPressed: isEnabled ? _onVerifyPressed : null,
        child: Text(
          '인증하기',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: isEnabled ? AppColors.white : AppColors.textSecondary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  /// 인증하기 버튼 클릭 처리
  Future<void> _onVerifyPressed() async {
    final link = _linkController.text.trim();
    if (link.isEmpty) return;
    
    try {
      
      // 보너스 인증 API 호출
      await ref.read(bonusProofNotifierProvider.notifier).submitProof(
        widget.stepId,
        ProofType.link,
        link,
      );
      
      // 상태 확인
      final state = ref.read(bonusProofNotifierProvider);
      
      if (mounted) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            // 인증 완료 후 완료 화면으로 이동 (기존 레벨업 정보 전달)
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VerificationCompleteScreen(
                  method: 'link',
                  content: link,
                  leveledUp: widget.leveledUp,
                  currentLevel: widget.currentLevel,
                ),
              ),
            );
          },
          levelUp: (data) {
            
            // 레벨업과 함께 인증 완료 화면으로 이동 (기존 또는 API 레벨업 정보 중 하나라도 true면 레벨업)
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VerificationCompleteScreen(
                  method: 'link',
                  content: link,
                  leveledUp: widget.leveledUp || true, // 기존 레벨업 또는 API 레벨업
                  currentLevel: data.currentLevel, // API 응답의 현재 레벨 사용
                ),
              ),
            );
          },
          failure: (message) {
            
            // 실패 시 에러 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('링크 인증 실패: $message'),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      }
    } catch (e) {
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('링크 인증 처리 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
