import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/main/presentation/widgets/withdraw_confirmation_dialog.dart';

/// 계정 화면
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _userEmail;
  String? _userName;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final email = authStorage.getEmail();
      final name = authStorage.getNickname();
      final profileUrl = authStorage.getProfileImageUrl();
      
      setState(() {
        _userEmail = email;
        _userName = name;
        _profileImageUrl = profileUrl;
      });
    } catch (e) {
      print('❌ 사용자 데이터 로드 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildProfileSection(),
                    const SizedBox(height: 32),
                    _buildNameSection(),
                    const SizedBox(height: 24),
                    _buildEmailSection(),
                    const SizedBox(height: 32),
                    _buildLogoutInfo(),
                    const SizedBox(height: 40),
                    _buildWithdrawButton(context),
                    const SizedBox(height: 32),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const Center(
              child: Text(
                '계정',
                style: TextStyle(
                  fontSize: 18,
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

  /// 프로필 섹션 (프로필 사진)
  Widget _buildProfileSection() {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: AppColors.cardBorder,
        backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
            ? NetworkImage(_profileImageUrl!)
            : null,
        child: _profileImageUrl == null || _profileImageUrl!.isEmpty
            ? const Icon(
                Icons.person,
                size: 50,
                color: AppColors.textSecondary,
              )
            : null,
      ),
    );
  }

  /// 이름 섹션
  Widget _buildNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이름',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Text(
            _userName ?? '이름을 불러오는 중...',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  /// 이메일 섹션
  Widget _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이메일',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Text(
            _userEmail ?? '이메일을 불러오는 중...',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  /// 로그아웃 안내문
  Widget _buildLogoutInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: const Text(
        '로그아웃 시 기기의 데이터가 초기화 됩니다.\n동일 계정으로 재로그인 시 데이터를 다시 불러 올 수 있습니다.',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 회원탈퇴 버튼
  Widget _buildWithdrawButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => _onWithdrawPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: AppColors.textSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          '회원 탈퇴',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  /// 회원탈퇴 버튼 클릭 처리
  void _onWithdrawPressed(BuildContext context) {
    WithdrawConfirmationDialog.show(
      context,
      userName: _userName ?? '',
      onConfirm: () async {
        Navigator.of(context).pop();
        await _performWithdraw(context);
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );
  }



  /// 회원탈퇴 실행
  Future<void> _performWithdraw(BuildContext context) async {
    try {
      // API 호출을 위한 AuthNotifier 생성
      final authNotifier = await createAuthNotifier();
      
      // 회원탈퇴 API 호출
      final success = await authNotifier.withdraw();
      
      if (success) {
        print('✅ 회원탈퇴 성공');
        
        // 성공 시 Navigator를 완전히 리셋하여 AuthWrapper가 다시 초기화되도록 함
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => false,
          );
        }
      } else {
        print('❌ 회원탈퇴 실패');
        
        // 실패 시 현재 화면 유지하고 실패 메시지 표시
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('회원탈퇴에 실패했습니다. 다시 시도해주세요.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('❌ 회원탈퇴 처리 중 오류 발생: $e');
      
      // 에러 발생 시 현재 화면 유지하고 에러 메시지 표시
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('회원탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
