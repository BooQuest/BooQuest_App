/// 사용자 부업 선택 API 응답 Entity
class UserSideJobEntity {
  final int id;
  final int sideJobId;
  final String title;
  final String description;
  final String status;
  final String startedAt;
  final String endedAt;
  final String result;

  const UserSideJobEntity({
    required this.id,
    required this.sideJobId,
    required this.title,
    required this.description,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    required this.result,
  });

  /// API 응답에서 Entity 생성
  factory UserSideJobEntity.fromJson(Map<String, dynamic> json) {
    return UserSideJobEntity(
      id: json['id'] ?? 0,
      sideJobId: json['sideJobId'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      startedAt: json['startedAt'] ?? '',
      endedAt: json['endedAt'] ?? '',
      result: json['result'] ?? '',
    );
  }

  /// 성공 여부 확인
  bool get isSuccess => result == 'created';
}
