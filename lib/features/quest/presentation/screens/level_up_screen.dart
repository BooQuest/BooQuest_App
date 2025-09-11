import 'package:flutter/material.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 레벨업 화면
/// 
/// 미션 완료 후 경험치가 오르고 다음 레벨로 올라갈 때 표시되는 화면입니다.
/// 캐릭터의 진화 과정을 시각적으로 보여주며, 사용자가 레벨업을 확인할 수 있습니다.
class LevelUpScreen extends StatefulWidget {
  final int newLevel;
  final VoidCallback? onComplete;

  const LevelUpScreen({
    super.key,
    required this.newLevel,
    this.onComplete,
  });

  @override
  State<LevelUpScreen> createState() => _LevelUpScreenState();
}

class _LevelUpScreenState extends State<LevelUpScreen> with TickerProviderStateMixin {
  String? characterType;
  bool isLoading = true;
  AuthStorageService? _authStorageService;
  
  // 애니메이션 컨트롤러들
  late AnimationController _titleController;
  late AnimationController _characterController;
  late AnimationController _arrowController;
  late AnimationController _levelController;
  
  // 애니메이션들
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _titleScaleAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _previousCharacterFadeAnimation;
  late Animation<double> _evolvedCharacterFadeAnimation;
  late Animation<double> _arrowPulseAnimation;
  late Animation<int> _levelCountAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadCharacterType(); // async 메서드이지만 await 없이 호출
  }
  
  /// 애니메이션 초기화
  void _initializeAnimations() {
    // 타이틀 애니메이션 (페이드인 + 스케일 + 슬라이드)
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
    );
    _titleScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.elasticOut),
    );
    _titleSlideAnimation = Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutBack),
    );
    
    // 캐릭터 애니메이션 (순차적 등장)
    _characterController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _previousCharacterFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _characterController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    _evolvedCharacterFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _characterController, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)),
    );
    
    // 화살표 펄스 애니메이션
    _arrowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _arrowPulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
    
    // 레벨 카운트업 애니메이션
    _levelController = AnimationController(
      duration: const Duration(milliseconds: 800), // 2초 → 0.8초로 단축
      vsync: this,
    );
    _levelCountAnimation = IntTween(begin: 0, end: widget.newLevel).animate(
      CurvedAnimation(parent: _levelController, curve: Curves.easeOut),
    );
    
  }

  /// AuthStorageService에서 캐릭터 타입 로드
  Future<void> _loadCharacterType() async {
    try {
      _authStorageService = await AuthStorageService.getInstance();
      final type = _authStorageService?.getCharacterType() ?? 'BLACK';
      setState(() {
        characterType = type;
        isLoading = false;
      });
      
      // 애니메이션 시작
      _startAnimations();
    } catch (e) {
      setState(() {
        characterType = 'BLACK'; // 기본값
        isLoading = false;
      });
      
      // 애니메이션 시작
      _startAnimations();
    }
  }
  
  /// 애니메이션 시작
  void _startAnimations() {
    // 순차적으로 애니메이션 시작
    _titleController.forward();
    
    Future.delayed(const Duration(milliseconds: 500), () {
      _characterController.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 1000), () {
      _arrowController.repeat(reverse: true);
      _levelController.forward();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _characterController.dispose();
    _arrowController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  /// 캐릭터 이미지 경로 생성
  String _getCharacterImagePath(int level, {bool isPrevious = false}) {
    if (characterType == null) return '';
    
    final typePrefix = characterType == 'BLACK' ? 'B' : 'W';
    final targetLevel = isPrevious ? level - 1 : level;
    
    // 레벨 범위 제한 (1-7)
    final clampedLevel = targetLevel.clamp(1, 7);
    
    return 'assets/images/quest/standing_$typePrefix$clampedLevel.png';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                // 상단 텍스트 섹션
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                    const SizedBox(height: 40),
                    // LEVEL UP! 텍스트 (애니메이션 적용)
                    SlideTransition(
                      position: _titleSlideAnimation,
                      child: FadeTransition(
                        opacity: _titleFadeAnimation,
                        child: ScaleTransition(
                          scale: _titleScaleAnimation,
                          child: const Text(
                            'LEVEL UP!',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 계정 레벨업 텍스트 (애니메이션 적용)
                    FadeTransition(
                      opacity: _titleFadeAnimation,
                      child: const Text(
                        '계정 레벨업',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 레벨 숫자 (카운트업 애니메이션)
                    AnimatedBuilder(
                      animation: _levelCountAnimation,
                      builder: (context, child) {
                        return Text(
                          '${_levelCountAnimation.value}',
                          style: const TextStyle(
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 0.8,
                          ),
                        );
                      },
                    ),
                  ],
                  ),
                ),

                // 중앙 캐릭터 진화 섹션
                SizedBox(
                  height: 400, // 고정 높이 설정
                  child: Stack(
                    children: [
                      // 진화된 캐릭터 (화면 정가운데)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 30,
                        child: Center(
                          child: FadeTransition(
                            opacity: _evolvedCharacterFadeAnimation,
                            child: _buildEvolvedCharacter(),
                          ),
                        ),
                      ),
                      
                      // 이전 캐릭터 (화면 가장 왼쪽)
                      Positioned(
                        left: 0,
                        bottom: 80,
                        child: FadeTransition(
                          opacity: _previousCharacterFadeAnimation,
                          child: _buildPreviousCharacter(),
                        ),
                      ),
                      
                      // 화살표 (두 캐릭터의 정중앙) - 펄스 애니메이션
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.25 - 30, // 화면 너비의 1/4에서 화살표 너비의 절반만큼 빼기
                        bottom: 250,
                        child: AnimatedBuilder(
                          animation: _arrowPulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _arrowPulseAnimation.value,
                              child: _buildArrow(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  /// 이전 캐릭터 (작고 흐릿한 상태)
  Widget _buildPreviousCharacter() {
    final imagePath = _getCharacterImagePath(widget.newLevel, isPrevious: true);
    
    return Opacity(
      opacity: 0.6, // 이미지와 비슷한 투명도
      child: imagePath.isNotEmpty
          ? Transform.translate(
              offset: const Offset(-50, 0), 
              child: Image.asset(
                imagePath,
                width: 200, 
                height: 180,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackCharacter(isPrevious: true);
                },
              ),
            )
          : _buildFallbackCharacter(isPrevious: true),
    );
  }


  /// 화살표 위젯 (upto.png 사용)
  Widget _buildArrow() {
    return Container(
      width: 60,
      height: 30,
      child: Image.asset(
        'assets/images/quest/upto.png',
        width: 60,
        height: 30,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // 이미지 로드 실패 시 기본 화살표
          return CustomPaint(
            painter: ArrowPainter(),
          );
        },
      ),
    );
  }

  /// 진화된 캐릭터 (크고 생생한 상태)
  Widget _buildEvolvedCharacter() {
    final imagePath = _getCharacterImagePath(widget.newLevel, isPrevious: false);
    
    return Container(
      width: 300,
      height: 350,
      child: imagePath.isNotEmpty
          ? Image.asset(
              imagePath,
              width: 300,
              height: 350,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallbackCharacter(isPrevious: false);
              },
            )
          : _buildFallbackCharacter(isPrevious: false),
    );
  }



  /// 폴백 캐릭터 (이미지 로드 실패 시)
  Widget _buildFallbackCharacter({required bool isPrevious}) {
    final size = isPrevious ? 150.0 : 300.0;
    final height = isPrevious ? 180.0 : 350.0;
    
    if (isPrevious) {
      // 이전 캐릭터는 Container 없이 Icon만
      return Icon(
        Icons.pets,
        size: 60,
        color: Colors.grey,
      );
    } else {
      // 진화된 캐릭터는 Container 유지
      return Container(
        width: size,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Center(
          child: Icon(
            Icons.pets,
            size: 120,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  /// 하단 버튼 (next_quest_setup_screen.dart와 동일한 구조)
  Widget _buildBottomButton(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.onComplete != null) {
                      widget.onComplete!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// 화살표 그리기용 CustomPainter
class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90E2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // 화살표 그리기
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.2,
      size.width * 0.6, size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.4,
      size.width, size.height * 0.5,
    );
    
    // 화살표 머리
    path.moveTo(size.width - 8, size.height * 0.5 - 4);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width - 8, size.height * 0.5 + 4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



