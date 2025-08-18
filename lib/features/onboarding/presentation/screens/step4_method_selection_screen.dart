import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/core/storage/local_storage_service.dart';

/// 온보딩 4단계 - 자신 있는 방식 선택 화면
class Step4MethodSelectionScreen extends StatefulWidget {
  const Step4MethodSelectionScreen({super.key});

  @override
  State<Step4MethodSelectionScreen> createState() => _Step4MethodSelectionScreenState();
}

class _Step4MethodSelectionScreenState extends State<Step4MethodSelectionScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _titleToOptionsSpacing = 40.0;
  static const double _optionsToButtonSpacing = 120.0;
  static const double _topRowCompensation = 16.0;

  String? _selectedOption;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _saveCurrentStep();
    _loadSavedStrengthType(); // 저장된 자신 있는 방식 타입 불러오기
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.setCurrentOnboardingStep(4);
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 자신 있는 방식 타입 불러오기
  Future<void> _loadSavedStrengthType() async {
    try {
      final storage = await LocalStorageService.getInstance();
      final savedStrengthType = storage.getStrengthType();
      if (savedStrengthType != null) {
        setState(() {
          _selectedOption = savedStrengthType;
        });
        print('📖 저장된 자신 있는 방식 타입 불러옴: $savedStrengthType');
      }
    } catch (error) {
      print('❌ 저장된 자신 있는 방식 타입 불러오기 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    _buildTopRow(),
                    const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                    _buildTitle(),
                    const SizedBox(height: _titleToOptionsSpacing),
                    _buildOptions(),
                    const SizedBox(height: _optionsToButtonSpacing),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(),
          ),
          if (_isLoading) const AILoadingOverlay(
            title: 'AI가 당신에게 맞는\n부업을 분석하고 있어요...',
            subtitle: '',
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => _goBack(),
        ),
        const Expanded(
          child: Center(child: OnboardingProgress(currentStep: 3)),  // 5단계 중 네번째
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
                '어떤 방식이\n더 자신 있으신가요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '가장 능숙하고 편하게 하실 수 있는 방식을 선택해 주세요',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary.withOpacity(0.6),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SvgPicture.asset(
          'assets/images/characters/basic_icon_1.svg',
          width: 39,
          height: 39,
        ),
      ],
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        _buildOptionButton('창작하기', Icons.auto_awesome, '창작하기'),
        const SizedBox(height: 12),
        _buildOptionButton('정리·전달하기', Icons.article, '정리·전달하기'),
        const SizedBox(height: 12),
        _buildOptionButton('일상 공유하기', Icons.share, '일상 공유하기'),
        const SizedBox(height: 12),
        _buildOptionButton('트렌드 파악하기', Icons.trending_up, '트렌드 파악하기'),
      ],
    );
  }

  Widget _buildOptionButton(String label, IconData icon, String value) {
    final bool isSelected = _selectedOption == value;
    
    return GestureDetector(
      onTap: () async {
        setState(() => _selectedOption = value);
        // 선택 시 즉시 저장
        await _saveStrengthTypeRealtime(value);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : AppColors.chipUnselectedBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.chipBorder : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : _getIconColor(value),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.chipSelectedText : AppColors.chipUnselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor(String value) {
    switch (value) {
      case '창작하기':
        return Colors.amber;
      case '정리·전달하기':
        return Colors.blue;
      case '일상 공유하기':
        return Colors.green;
      case '트렌드 파악하기':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildBottomBar() {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + bottomInset,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 46,
                      child: ElevatedButton(
              onPressed: (_selectedOption != null && !_isLoading) ? _onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedOption != null && !_isLoading) ? AppColors.buttonActive : AppColors.buttonInactive,
                foregroundColor: AppColors.buttonText,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                '다음',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
        ),
      ),
    );
  }



  Future<void> _onNext() async {
    if (_selectedOption != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // 부업 추천 API 호출
        await _callSideJobRecommendationAPI();
        
        // API 호출 성공 시 다음 화면으로 이동
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SideJobRecommendationsScreen()),
          );
        }
      } catch (error) {
        print('❌ 부업 추천 API 호출 실패: $error');
        // 에러 발생 시에도 다음 화면으로 이동 (임시)
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SideJobRecommendationsScreen()),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  /// 부업 추천 API 호출
  Future<void> _callSideJobRecommendationAPI() async {
    try {
      
      // local storage에서 필요한 데이터 가져오기
      final storage = await LocalStorageService.getInstance();
      final userId = storage.getUserId();
      final job = storage.getJob();
      final hobbies = storage.getHobbies();
      final expressionStyle = storage.getExpressionStyle(); // step3에서 선택한 값
      
      // Request parameter 구성
      final requestData = {
        'userId': userId,
        'job': job ?? '',
        'hobbies': hobbies,
        'expressionStyle': expressionStyle,
        'strengthType': _selectedOption,
        'desiredSideJob': '',
      };

      print('📤 실제 전송될 JSON 데이터:');
      print('  ${requestData.toString()}');
      
      final response = await NetworkClient().post('/api/onboarding', data: requestData);
      
      print('📥 부업 추천 API 응답:');
      print('  - 상태 코드: ${response.statusCode}');
      print('  - 응답 데이터: ${response.data}');
      
      // 응답 구조에 따른 처리
      final responseData = response.data;
      if (responseData['success'] == true) {
        print('✅ 부업 추천 API 성공!');
        print('📦 추천 데이터: ${responseData['data']}');
        
      } else {
        print('❌ 부업 추천 API 실패');
        print('🚨 에러 메시지: ${responseData['message']}');
        print('🚨 상태 코드: ${responseData['status']}');
      }
      
    } catch (error) {
      print('❌ 부업 추천 API 호출 중 에러: $error');
      rethrow;
    }
  }

  /// 자신 있는 방식 타입 실시간 저장
  Future<void> _saveStrengthTypeRealtime(String strengthType) async {
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.setStrengthType(strengthType);
      print('💾 자신 있는 방식 타입 실시간 저장 성공: $strengthType');
    } catch (error) {
      print('❌ 자신 있는 방식 타입 실시간 저장 실패: $error');
    }
  }


  Future<void> _goToRecommendations() async {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SideJobRecommendationsScreen()),
    );
  }

  Future<void> _goBack() async {
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const Step3PreferredMethodScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }
}
