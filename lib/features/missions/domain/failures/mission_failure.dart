/// Missions feature failure model
class MissionFailure {
  final String userMessage;
  final String debugMessage;

  const MissionFailure(this.userMessage, [this.debugMessage = '']);

  @override
  String toString() => 'MissionFailure(userMessage: $userMessage, debug: $debugMessage)';

  static MissionFailure server(String message) => MissionFailure(message.isNotEmpty ? message : '서버 오류가 발생했어요. 잠시 후 다시 시도해주세요.');
  static MissionFailure network(String message) => MissionFailure('네트워크 오류가 발생했어요. 연결을 확인해주세요.', message);
  static MissionFailure data([String message = '데이터 처리 중 오류가 발생했어요.']) => MissionFailure(message);
  static MissionFailure unknown(String message) => MissionFailure('알 수 없는 오류가 발생했어요.', message);
}


