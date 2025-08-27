import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_sidejob_entity.freezed.dart';
part 'user_sidejob_entity.g.dart';

/// 사용자 사이드잡 엔티티
@freezed
class UserSideJobEntity with _$UserSideJobEntity {
  const factory UserSideJobEntity({
    required int id,
    required int sideJobId,
    required String title,
    required String description,
    required String status,
    required String startedAt,
    String? endedAt,
    required String period,
  }) = _UserSideJobEntity;

  factory UserSideJobEntity.fromJson(Map<String, dynamic> json) =>
      _$UserSideJobEntityFromJson(json);
}

/// 사용자 사이드잡 목록 응답 엔티티
@freezed
class UserSideJobListEntity with _$UserSideJobListEntity {
  const factory UserSideJobListEntity({
    required List<UserSideJobEntity> sideJobs,
  }) = _UserSideJobListEntity;

  factory UserSideJobListEntity.fromJson(Map<String, dynamic> json) =>
      _$UserSideJobListEntityFromJson(json);
}
