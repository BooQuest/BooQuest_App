// 사용자 입력: "안녕하세요"
//         ↓
// 타이머 시작 (350ms)
//          ↓
// 350ms 내에 추가 입력이 없으면 → 저장 실행
// 350ms 내에 추가 입력이 있으면 → 타이머 리셋

import 'dart:async';

class Debouncer {
  Debouncer(this.delayMs);
  final int delayMs;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMs), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
