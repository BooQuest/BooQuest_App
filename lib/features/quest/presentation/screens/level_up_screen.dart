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

class _LevelUpScreenState extends State<LevelUpScreen> {
  String? characterType;
  bool isLoading = true;
  late final AuthStorageService _authStorageService;

  @override
  void initState() {
    super.initState();
    _authStorageService = AuthStorageService();
    _loadCharacterType();
  }

  /// AuthStorageService에서 캐릭터 타입 로드
  void _loadCharacterType() {
    try {
      final type = _authStorageService.getCharacterType() ?? 'BLACK';
      setState(() {
        characterType = type;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        characterType = 'BLACK'; // 기본값
        isLoading = false;
      });
    }
  }

  /// 캐릭터 이미지 경로 생성
  String _getCharacterImagePath(int level, {bool isPrevious = false}) {
    if (characterType == null) return '';
    
    final typePrefix = characterType == 'BLACK' ? 'B' : 'W';
    final targetLevel = isPrevious ? level - 1 : level;
    
    // 레벨 범위 제한 (1-7)
    final clampedLevel = targetLevel.clamp(1, 7);
    
    return 'assets/images/characters/standing_${typePrefix}${clampedLevel}.png';
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
            border: Border(
              left: BorderSide(color: Color(0xFF4A90E2), width: 2),
              right: BorderSide(color: Color(0xFF4A90E2), width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 상단 텍스트 섹션
                Column(
                  children: [
                    const SizedBox(height: 40),
                    // LEVEL UP! 텍스트
                    const Text(
                      'LEVEL UP!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 계정 레벨업 텍스트
                    const Text(
                      '계정 레벨업',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 레벨 숫자
                    Text(
                      '${widget.newLevel}',
                      style: const TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 0.8,
                      ),
                    ),
                  ],
                ),

                // 중앙 캐릭터 진화 섹션
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 이전 캐릭터 (작고 흐릿함)
                        _buildPreviousCharacter(),
                        
                        const SizedBox(width: 20),
                        
                        // 화살표
                        _buildArrow(),
                        
                        const SizedBox(width: 20),
                        
                        // 진화된 캐릭터 (크고 생생함)
                        _buildEvolvedCharacter(),
                      ],
                    ),
                  ),
                ),

                // 하단 완료 버튼
                _buildCompleteButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 이전 캐릭터 (작고 흐릿한 상태)
  Widget _buildPreviousCharacter() {
    final imagePath = _getCharacterImagePath(widget.newLevel, isPrevious: true);
    
    return Opacity(
      opacity: 0.6, // 이미지와 비슷한 투명도
      child: Container(
        width: 80,
        height: 100,
        child: imagePath.isNotEmpty
            ? Image.asset(
                imagePath,
                width: 80,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackCharacter(isPrevious: true);
                },
              )
            : _buildFallbackCharacter(isPrevious: true),
      ),
    );
  }

  /// 진화된 캐릭터 (크고 생생한 상태)
  Widget _buildEvolvedCharacter() {
    final imagePath = _getCharacterImagePath(widget.newLevel, isPrevious: false);
    
    return Container(
      width: 100,
      height: 120,
      child: imagePath.isNotEmpty
          ? Image.asset(
              imagePath,
              width: 100,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallbackCharacter(isPrevious: false);
              },
            )
          : _buildFallbackCharacter(isPrevious: false),
    );
  }


  /// 화살표 위젯 (upto.png 사용)
  Widget _buildArrow() {
    return Container(
      width: 40,
      height: 20,
      child: Image.asset(
        'assets/images/quest/upto.png',
        width: 40,
        height: 20,
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

  /// 폴백 캐릭터 (이미지 로드 실패 시)
  Widget _buildFallbackCharacter({required bool isPrevious}) {
    final size = isPrevious ? 80.0 : 100.0;
    final height = isPrevious ? 100.0 : 120.0;
    
    return Container(
      width: size,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: const Center(
        child: Icon(
          Icons.pets,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// 완료 버튼
  Widget _buildCompleteButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(bottom: 20),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          '완료',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
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
