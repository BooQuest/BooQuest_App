import 'dart:math' as math;
import 'package:flutter/material.dart';

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

class _AILoadingOverlayState extends State<AILoadingOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _loaderController;

  @override
  void initState() {
    super.initState();
    _loaderController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          decoration: BoxDecoration(
            color: widget.cardColor ?? Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sleek pulsing dots loader
              AnimatedBuilder(
                animation: _loaderController,
                builder: (context, _) {
                  final t = _loaderController.value;
                  double scaleFor(int i) {
                    return 0.6 + 0.4 * (0.5 * (1 + math.sin(2 * math.pi * (t + i / 3))));
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        Transform.scale(
                          scale: scaleFor(i),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: widget.dotColor ?? const Color(0xFF5B86E5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        if (i < 2) const SizedBox(width: 10),
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
