import 'package:flutter/material.dart';

/// 왼쪽에서 오른쪽으로 슬라이드 인 되는 페이지 전환
class SlideFromLeftPageRoute<T> extends PageRouteBuilder<T> {
  SlideFromLeftPageRoute({required WidgetBuilder builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0); // 왼쪽에서 시작
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutCubic));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: const Duration(milliseconds: 280),
        );
}
