import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/auth/presentation/auth_wrapper.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

class MyScreen extends ConsumerStatefulWidget {
  const MyScreen({super.key});

  @override
  ConsumerState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends ConsumerState<MyScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _sectionSpacing = 32.0;

  Future<String> _loadDisplayName() async {
    final storage = await OnboardingStorageService.getInstance();
    final name = storage.getCharacterName();
    return (name == null || name.isEmpty) ? '김소현' : name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              
              // User Profile Section
              FutureBuilder<String>(
                future: _loadDisplayName(),
                builder: (context, snapshot) {
                  final displayName = '소현';
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'sohyun01@kakao.com',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textHint,
                                  decoration: TextDecoration.underline,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.pets,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 32),

              // Management Section
              const Text(
                '관리',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                ),
                child: Column(
                  children: [
                    _ManagementItem(
                      icon: Icons.help_outline,
                      label: '자주 묻는 질문',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
                    _ManagementItem(
                      icon: Icons.contact_support_outlined,
                      label: '문의하기',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
                    _ManagementItem(
                      icon: Icons.description_outlined,
                      label: '이용약관',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
                    _ManagementItem(
                      icon: Icons.privacy_tip_outlined,
                      label: '개인정보 처리 방침',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Feedback Section
              const Text(
                '부퀘스트에게 바라는 점',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '1/300',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        maxLines: 5,
                        maxLength: 300,
                        decoration: const InputDecoration(
                          hintText: '부퀘스트에 대한 의견이나 개선사항을 자유롭게 작성해주세요.',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textHint,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                        textInputAction: TextInputAction.done,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () => _handleLogout(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.cardBorder, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.textPrimary,
                  ),
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    try {
      // JWT 토큰과 사용자 정보 삭제 (AuthStorageService)
      final authStorage = await AuthStorageService.getInstance();
      await authStorage.setAccessToken('');
      await authStorage.setRefreshToken('');
      await authStorage.removeUserId();
      await authStorage.setEmail('');
      await authStorage.setProfileImageUrl('');
      
      // 온보딩 완료 상태 초기화 (LocalStorageService)
      final storage = await LocalStorageService.getInstance();
      await storage.setOnboardingCompleted(false);
      
      // 온보딩 데이터 초기화 (OnboardingStorageService)
      final onboardingStorage = await OnboardingStorageService.getInstance();
      await onboardingStorage.clearAllData();
      
    } catch (e) {
      print('로그아웃 중 오류: $e');
    }

    if (!context.mounted) return;
    
    // AuthWrapper로 이동 (AuthWrapper에서 인증 상태를 확인하여 LoginPage로 라우팅)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthWrapper()),
      (route) => false,
    );
  }


}

class _ManagementItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ManagementItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textHint,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textHint,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}