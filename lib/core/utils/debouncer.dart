// 사용자 입력: "안녕하세요"
//         ↓
// 타이머 시작 (500ms) - 성능 최적화를 위해 적절한 딜레이
//          ↓
// 500ms 내에 추가 입력이 없으면 → 저장 실행
// 500ms 내에 추가 입력이 있으면 → 타이머 리셋

import 'dart:async';

class Debouncer {
  Debouncer(this.delayMs);
  final int delayMs;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMs), () {
      print('⏰ Debouncer 실행 (${delayMs}ms 딜레이 후)');
      action();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}

// 온보딩 입력용 Debouncer 상수
class OnboardingDebouncer {
  static const int inputDelay = 500; // 500ms 딜레이
  static const int saveDelay = 1000; // 저장용 1초 딜레이
}
