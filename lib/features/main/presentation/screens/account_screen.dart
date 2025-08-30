import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

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
                    const SizedBox(height: 24),
                    _buildLogoutButton(context),
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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _userEmail ?? '이메일을 불러오는 중...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: _onWithdrawPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '탈퇴하기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
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
        '로그아웃 시 기기의 데이터가 초기화 됩니다. 동일 계정으로 재로그인 시 데이터를 다시 불러 올 수 있습니다.',
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

  /// 로그아웃 버튼
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => _onLogoutPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          '로그아웃',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 탈퇴하기 버튼 클릭 처리
  void _onWithdrawPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('계정 탈퇴'),
          content: const Text('정말로 계정을 탈퇴하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: 계정 탈퇴 로직 구현
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('계정 탈퇴 기능은 준비 중입니다.')),
                );
              },
              child: const Text(
                '탈퇴',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 로그아웃 버튼 클릭 처리
  void _onLogoutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말로 로그아웃하시겠습니까?\n기기의 데이터가 초기화됩니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _performLogout(context);
              },
              child: const Text(
                '로그아웃',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 로그아웃 실행
  Future<void> _performLogout(BuildContext context) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      await authStorage.clearAuthData();
      
      if (context.mounted) {
        // 로그인 화면으로 이동
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } catch (e) {
      print('❌ 로그아웃 실패: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그아웃 중 오류가 발생했습니다.')),
        );
      }
    }
  }
}
