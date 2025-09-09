import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/main/presentation/screens/account_screen.dart';
import 'package:booquest/features/main/presentation/widgets/open_source_license_screen.dart';
import 'package:booquest/features/main/presentation/widgets/service_preparing_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// 설정 화면
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _userEmail;
  String? _appVersion;
  String? _buildNumber;

  // 반응형을 위한 화면 크기 계산 (home_screen.dart와 동일한 구조)
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
    _loadAppInfo();
  }

  Future<void> _loadUserEmail() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final email = authStorage.getEmail();
      setState(() {
        _userEmail = email;
      });
    } catch (e) {
      // 이메일 로드 실패
    }
  }

  /// 앱 정보 로드 (버전, 빌드 번호)
  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    } catch (e) {
      // 앱 정보 로드 실패
    }
  }

  /// 계정 화면으로 이동
  void _navigateToAccountScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AccountScreen(),
      ),
    );
  }

  /// 오픈소스 라이선스 화면으로 이동
  void _navigateToLicenseScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const OpenSourceLicenseScreen(),
      ),
    );
  }

  /// URL 실행 
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // URL 실행 실패
      }
    } catch (e) {
      // URL 실행 중 오류 발생
    }
  }

  /// 로그아웃 처리
  Future<void> _handleLogout() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      
      // 1. 서버에 로그아웃 API 호출 (성공/실패 무관)
      try {
        final refreshToken = authStorage.getRefreshToken();
        if (refreshToken != null) {
          // API 호출을 위한 AuthNotifier 생성
          final authNotifier = await createAuthNotifier();
          await authNotifier.logout();
          // 로그아웃 API 호출 완료
        } else {
          // Refresh token이 없어서 API 호출 생략
        }
      } catch (e) {
        // 로그아웃 API 호출 실패
        // API 실패해도 로컬 데이터는 삭제
      }
      
      // 2. 로컬 데이터 삭제 (API 성공/실패 무관)
      await authStorage.clearAuthData();
      // 로컬 데이터 삭제 완료
      
      // 3. Navigator를 완전히 리셋하여 AuthWrapper가 다시 초기화되도록 함
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      }
    } catch (e) {
      // 로그아웃 처리 중 오류 발생
      // 에러가 발생해도 로그인 페이지로 이동
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      }
    }
  }

  /// 로그아웃 처리 (다이얼로그 없이 바로 실행)
  void _handleLogoutDirectly() {
    _handleLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            SizedBox(height: _isSmallScreen ? 16 : 20),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccountSection(),
                    SizedBox(height: _isSmallScreen ? 24 : 32),
                    _buildSecuritySection(),
                    // SizedBox(height: _isSmallScreen ? 24 : 32),
                    // _buildPaymentSection(),
                    SizedBox(height: _isSmallScreen ? 24 : 32),
                    _buildSupportSection(),
                    SizedBox(height: _isSmallScreen ? 32 : 40),
                    _buildLogoutSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 상단 바 (뒤로가기 + 제목)
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
            ),
            Center(
              child: Text(
                '설정',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 계정 섹션
  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '계정',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 10 : 12),
        GestureDetector(
          onTap: () => _navigateToAccountScreen(context),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(_isSmallScreen ? 14 : 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              children: [
                Text(
                  _userEmail ?? '이메일을 불러오는 중...',
                  style: TextStyle(
                    fontSize: _isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 보안 섹션
  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '보안',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 10 : 12),
        _buildSettingItem('이용약관', onTap: () => _launchUrl('https://feline-driver-bf7.notion.site/25928b64b1bf80c0818dd120cb13a42e')),
        SizedBox(height: _isSmallScreen ? 6 : 8),
        _buildSettingItem('개인정보 처리 방침', onTap: () => _launchUrl('https://feline-driver-bf7.notion.site/25828b64b1bf809793f6e9e447e298b5')),
        SizedBox(height: _isSmallScreen ? 6 : 8),
        _buildSettingItem('오픈소스 라이선스', onTap: () => _navigateToLicenseScreen(context)),
        SizedBox(height: _isSmallScreen ? 6 : 8),
        _buildVersionInfoItem(),
      ],
    );
  }

  /// 결제/구독 관리 섹션
  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '결제/구독 관리',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 10 : 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Column(
            children: [
              Text(
                '곧 제공될 예정이예요',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _isSmallScreen ? 6 : 8),
              Text(
                '조금만 기다려주세요',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 고객지원 섹션
  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '고객지원',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 10 : 12),
        _buildSettingItem('문의하기/버그제보', onTap: () => _launchUrl('https://forms.gle/Em41EDxHkC3Nbixx8')),
        // SizedBox(height: _isSmallScreen ? 6 : 8),
        // _buildSettingItem('FAQ', onTap: () => ServicePreparingDialog.show(context)),
        // SizedBox(height: _isSmallScreen ? 6 : 8),
        // _buildSettingItem('리뷰 남기기', onTap: () => ServicePreparingDialog.show(context)),
      ],
    );
  }

  /// 버전 정보 아이템 위젯
  Widget _buildVersionInfoItem() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_isSmallScreen ? 14 : 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          Text(
            '버전·빌드 정보',
            style: TextStyle(
              fontSize: _isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            _appVersion != null && _buildNumber != null 
                ? 'v$_appVersion (build $_buildNumber)'
                : '버전 정보 로딩 중...',
            style: TextStyle(
              fontSize: _isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// 로그아웃 섹션
  Widget _buildLogoutSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _isSmallScreen ? 12 : 16),
      child: Center(
        child: GestureDetector(
          onTap: _handleLogoutDirectly,
          child: Text(
            '로그아웃',
            style: TextStyle(
              fontSize: _isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  /// 설정 아이템 위젯
  Widget _buildSettingItem(String title, {String? trailing, bool isDisabled = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(_isSmallScreen ? 14 : 16),
        decoration: BoxDecoration(
          color: isDisabled ? const Color(0xFFF8F8F8) : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDisabled ? const Color(0xFFE0E0E0) : AppColors.cardBorder,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: _isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: isDisabled ? AppColors.textSecondary : AppColors.textPrimary,
              ),
            ),
            if (trailing != null) ...[
              const Spacer(),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: _isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  color: isDisabled ? AppColors.textSecondary : AppColors.textPrimary,
                ),
              ),
            ],
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: isDisabled ? AppColors.textSecondary.withValues(alpha: 0.5) : AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
