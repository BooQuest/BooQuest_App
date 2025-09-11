import 'package:flutter/material.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 레벨업 화면
/// 
/// 미션 완료 후 경험치가 오르고 다음 레벨로 올라갈 때 표시되는 화면입니다.
/// 캐릭터의 진화 과정을 시각적으로 보여주며, 사용자가 레벨업을 확인할 수 있습니다.
class LevelUpScreen extends StatelessWidget {
  final int newLevel;
  final VoidCallback? onComplete;

  const LevelUpScreen({
    super.key,
    required this.newLevel,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
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
                      '$newLevel',
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
    return Opacity(
      opacity: 0.6,
      child: Container(
        width: 80,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 고양이 몸체 - 레벨에 따라 색상 변경
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: _getCharacterColor(newLevel - 1),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            // 귀
            Positioned(
              top: 5,
              child: Row(
                children: [
                  _buildEar(),
                  const SizedBox(width: 20),
                  _buildEar(),
                ],
              ),
            ),
            // 눈
            Positioned(
              top: 25,
              child: Row(
                children: [
                  _buildEye(),
                  const SizedBox(width: 20),
                  _buildEye(),
                ],
              ),
            ),
            // 이마 별
            Positioned(
              top: 15,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF87CEEB),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // 칼라
            Positioned(
              bottom: 15,
              child: Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF87CEEB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.star,
                    size: 8,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            // 꼬리
            Positioned(
              right: 0,
              top: 40,
              child: Container(
                width: 15,
                height: 30,
                decoration: BoxDecoration(
                  color: _getCharacterColor(newLevel - 1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 진화된 캐릭터 (크고 생생한 상태)
  Widget _buildEvolvedCharacter() {
    return Container(
      width: 100,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 고양이 몸체 - 현재 레벨에 따라 색상 변경
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: _getCharacterColor(newLevel),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          // 귀
          Positioned(
            top: 5,
            child: Row(
              children: [
                _buildEar(isEvolved: true),
                const SizedBox(width: 30),
                _buildEar(isEvolved: true),
              ],
            ),
          ),
          // 눈
          Positioned(
            top: 30,
            child: Row(
              children: [
                _buildEye(isEvolved: true),
                const SizedBox(width: 30),
                _buildEye(isEvolved: true),
              ],
            ),
          ),
          // 이마 별 (더 밝고 강렬함)
          Positioned(
            top: 20,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF4A90E2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 칼라 (나비넥타이 형태)
          Positioned(
            bottom: 20,
            child: Container(
              width: 70,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.star,
                  size: 12,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          // 꼬리 (더 길고 우아함)
          Positioned(
            right: 0,
            top: 50,
            child: Container(
              width: 20,
              height: 40,
              decoration: BoxDecoration(
                color: _getCharacterColor(newLevel),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 레벨에 따른 캐릭터 색상 반환
  Color _getCharacterColor(int level) {
    // 레벨에 따른 색상 그라데이션
    if (level <= 1) {
      return const Color(0xFF8B4513); // 갈색 (초기)
    } else if (level <= 2) {
      return const Color(0xFF654321); // 어두운 갈색
    } else if (level <= 3) {
      return const Color(0xFF2F4F4F); // 다크 슬레이트 그레이
    } else if (level <= 4) {
      return const Color(0xFF191970); // 미드나이트 블루
    } else if (level <= 5) {
      return const Color(0xFF4B0082); // 인디고
    } else if (level <= 6) {
      return const Color(0xFF8B008B); // 다크 매젠타
    } else {
      return const Color(0xFF000000); // 검은색 (최고 레벨)
    }
  }

  /// 귀 위젯
  Widget _buildEar({bool isEvolved = false}) {
    return Container(
      width: isEvolved ? 12 : 8,
      height: isEvolved ? 15 : 10,
      decoration: BoxDecoration(
        color: isEvolved ? _getCharacterColor(newLevel) : _getCharacterColor(newLevel - 1),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  /// 눈 위젯
  Widget _buildEye({bool isEvolved = false}) {
    return Container(
      width: isEvolved ? 8 : 6,
      height: isEvolved ? 8 : 6,
      decoration: const BoxDecoration(
        color: Color(0xFF4A90E2),
        shape: BoxShape.circle,
      ),
    );
  }

  /// 화살표 위젯
  Widget _buildArrow() {
    return Container(
      width: 40,
      height: 20,
      child: CustomPaint(
        painter: ArrowPainter(),
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
          if (onComplete != null) {
            onComplete!();
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
