import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 말풍선 꼬리를 그리는 CustomPainter
class SpeechBubbleTailPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  SpeechBubbleTailPainter({
    required this.color,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 챗봇 버튼 위젯
/// 오른쪽 하단에 고정되어 있는 챗봇 아이콘 버튼
class ChatbotButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool isVisible;

  const ChatbotButton({
    super.key,
    this.onTap,
    this.isVisible = true,
  });

  @override
  State<ChatbotButton> createState() => _ChatbotButtonState();
}

class _ChatbotButtonState extends State<ChatbotButton>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _pulseController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// 애니메이션 초기화
  void _initializeAnimations() {
    // 바운스 애니메이션 (클릭 시)
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));

    // 펄스 애니메이션 (주의를 끌기 위한)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  /// 애니메이션 시작
  void _startAnimations() {
    // 펄스 애니메이션을 3초마다 반복
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _pulseController.repeat(reverse: true);
      }
    });
  }

  /// 버튼 클릭 처리
  void _handleTap() {
    // 바운스 애니메이션 실행
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });

    // 콜백 실행
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      right: 16,
      bottom: 16, // 하단 탭 바로 위에 위치 (더 낮게)
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: Listenable.merge([_bounceAnimation, _pulseAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _bounceAnimation.value * _pulseAnimation.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                        // 텍스트 말풍선 (이미지 스타일)
                        Stack(
                          children: [
                             // 말풍선 본체 (작은 사이즈)
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(
                                   color: const Color(0xFF4BAFFF),
                                   width: 2,
                                 ),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withValues(alpha: 0.15),
                                     blurRadius: 6,
                                     offset: const Offset(0, 3),
                                   ),
                                 ],
                               ),
                               child: const Text(
                                 '부업, 도와드릴까요?',
                                 style: TextStyle(
                                   color: Color(0xFF4BAFFF),
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600,
                                   height: 1.2,
                                 ),
                               ),
                             ),
                          ],
                        ),
                  const SizedBox(height: 8),
                  // 원형 챗봇 버튼
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF4BAFFF), 
                            Color(0xFF3A9FE6), 
                          ],
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/chatbot.svg',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
