import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/quest/infrastructure/providers/image_proof_providers.dart';
import 'package:booquest/features/quest/application/states/image_proof_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';



/// 사진 인증 화면 - 부업 활동에 관한 모습을 간단히 남기기
class PhotoVerificationScreen extends ConsumerStatefulWidget {
  final int stepId;
  
  const PhotoVerificationScreen({
    super.key,
    required this.stepId,
  });

  @override
  ConsumerState<PhotoVerificationScreen> createState() => _PhotoVerificationScreenState();
}

class _PhotoVerificationScreenState extends ConsumerState<PhotoVerificationScreen> {
  int _currentIndex = 1; // Quest 탭이 선택된 상태
  File? _selectedImage; // 선택된 이미지 파일

  // 반응형을 위한 화면 크기 계산 (home_screen.dart와 동일한 구조)
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuestScreen(),
    const MyRecordScreen(),
  ];

  final ImagePicker _imagePicker = ImagePicker();

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 이미지 업로드 상태 감지
    ref.listen<ImageProofState>(imageProofNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (data) {
          // 성공 시 인증 완료 화면으로 이동
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationCompleteScreen(
                method: 'photo',
                content: '이미지 업로드 완료',
              ),
            ),
          );
        },
        failure: (message) {
          // 실패 시 에러 다이얼로그 표시
          _showErrorDialog(message);
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Home 화면
            const HomeScreen(),
            // Quest 화면 (현재 화면)
            _buildPhotoVerificationContent(),
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

  /// 사진 인증 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildPhotoVerificationContent() {
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
                _buildPhotoUploadSection(),
                SizedBox(height: _isSmallScreen ? 16 : 20),
                _buildFileSizeNotice(),
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
          '부업 활동에 관한 모습을',
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
        // 부제목/설명 (2줄로 분리)
        Text(
          '결과물에 대한 사진을 자유롭게 인증해 주세요',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        Text(
          '(ex.블로그 작성 중인 모니터 사진)',
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

  /// 파일 크기 안내 문구
  Widget _buildFileSizeNotice() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(_isSmallScreen ? 8 : 10),
        border: Border.all(
          color: const Color(0xFFE3F2FD),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: _isSmallScreen ? 16 : 18,
            color: AppColors.primary,
          ),
          SizedBox(width: _isSmallScreen ? 8 : 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '파일 크기 제한: ',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: '5MB 이하',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: '만 업로드 가능합니다',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 사진 업로드 섹션
  Widget _buildPhotoUploadSection() {
    return GestureDetector(
      onTap: _handleImageUploadTap,
      child: Container(
        width: double.infinity,
        height: _isSmallScreen ? 180 : 200,
        decoration: BoxDecoration(
          color: AppColors.cardBorder.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
        ),
        child: _selectedImage != null
            ? Stack(
                children: [
                  // 선택된 이미지 표시
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 편집 버튼 (우상단)
                  Positioned(
                    top: _isSmallScreen ? 6 : 8,
                    right: _isSmallScreen ? 6 : 8,
                    child: GestureDetector(
                      onTap: _handleImageUploadTap,
                      child: Container(
                        width: _isSmallScreen ? 28 : 32,
                        height: _isSmallScreen ? 28 : 32,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: _isSmallScreen ? 14 : 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: _isSmallScreen ? 50 : 60,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: _isSmallScreen ? 6 : 8),
                    Text(
                      '메인 사진을 선택해주세요',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: _isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  /// 인증하기 버튼
  Widget _buildVerifyButton() {
    final imageProofState = ref.watch(imageProofNotifierProvider);
    final isEnabled = _selectedImage != null && !imageProofState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    
    return Container(
      width: double.infinity,
      height: _isSmallScreen ? 50 : 56,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
      ),
      child: TextButton(
        onPressed: isEnabled ? _onVerifyPressed : null,
        child: imageProofState.maybeWhen(
          loading: () => SizedBox(
            width: _isSmallScreen ? 18 : 20,
            height: _isSmallScreen ? 18 : 20,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ),
          orElse: () => Text(
            '인증하기',
            style: TextStyle(
              fontSize: _isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: isEnabled ? AppColors.white : AppColors.textSecondary.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }

  /// 인증하기 버튼 클릭 처리
  Future<void> _onVerifyPressed() async {
    if (_selectedImage == null) return;
    
    // 이미지 업로드 API 호출 - File 객체 직접 전달
    await ref.read(imageProofNotifierProvider.notifier).uploadImageProof(
      widget.stepId,
      _selectedImage!,
    );
  }

  /// 이미지 업로드 영역 터치 처리
  Future<void> _handleImageUploadTap() async {
    // 바로 사진 선택 팝업 표시
    _showImageSourceDialog();
  }

  /// 이미지 소스 선택 다이얼로그 표시
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목
            const Text(
              '사진 선택',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            // 갤러리에서 선택
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text('갤러리에서 선택'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            // 카메라로 촬영
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('카메라로 촬영'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 갤러리에서 이미지 선택
  Future<void> _pickImageFromGallery() async {
    try {
      // 권한 요청 없이 바로 이미지 선택
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        // 이미지 크기 체크 (5MB 이하)
        final file = File(image.path);
        final fileSize = await file.length();
        final maxSize = 5 * 1024 * 1024; // 5MB
        
        if (fileSize > maxSize) {
          _showErrorDialog('이미지 크기가 5MB를 초과합니다. 더 작은 이미지를 선택해주세요.');
          return;
        }
        
        setState(() {
          _selectedImage = file;
        });
      }
    } catch (e) {
      _showErrorDialog('갤러리에서 이미지를 선택하는 중 오류가 발생했습니다.');
    }
  }

  /// 카메라로 이미지 촬영
  Future<void> _pickImageFromCamera() async {
    try {
      // 권한 요청 없이 바로 이미지 촬영
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        // 이미지 크기 체크 (5MB 이하)
        final file = File(image.path);
        final fileSize = await file.length();
        final maxSize = 5 * 1024 * 1024; // 5MB
        
        if (fileSize > maxSize) {
          _showErrorDialog('이미지 크기가 5MB를 초과합니다. 더 작은 이미지를 선택해주세요.');
          return;
        }
        
        setState(() {
          _selectedImage = file;
        });
      }
    } catch (e) {
      _showErrorDialog('카메라로 사진을 촬영하는 중 오류가 발생했습니다.');
    }
  }

  /// 오류 다이얼로그 표시
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
