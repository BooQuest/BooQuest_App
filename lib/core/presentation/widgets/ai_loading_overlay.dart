import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

/// AI 로딩 오버레이 공용 위젯
class AILoadingOverlay extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color? dotColor;
  final Color? backgroundColor;
  final Color? cardColor;

  const AILoadingOverlay({
    super.key,
    required this.title,
    required this.subtitle,
    this.dotColor,
    this.backgroundColor,
    this.cardColor,
  });

  @override
  State<AILoadingOverlay> createState() => _AILoadingOverlayState();
}

class _AILoadingOverlayState extends State<AILoadingOverlay> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  static const double _spinnerSize = 60.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG 로딩 스피너 (회전 애니메이션 추가)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2 * math.pi,
                  child: SvgPicture.asset(
                    'assets/images/characters/Loading_spinner.svg',
                    width: _spinnerSize,
                    height: _spinnerSize,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Text
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


