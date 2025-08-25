import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidejob_entity.freezed.dart';
part 'sidejob_entity.g.dart';

/// 부업 추천 결과 엔티티
@freezed
class SideJobEntity with _$SideJobEntity {
  const factory SideJobEntity({
    required String id,
    required String title,
    required String description,
  }) = _SideJobEntity;

  factory SideJobEntity.fromJson(Map<String, dynamic> json) =>
      _$SideJobEntityFromJson(json);
}

/// 부업 추천 요청 데이터
@freezed
class SideJobRequestData with _$SideJobRequestData {
  const factory SideJobRequestData({
    required int userId,
    required String nickname,
    required String job,
    required List<String> hobbies,
    required String expressionStyle,
    required String strengthType,
    required String characterType,
    required String characterName,
  }) = _SideJobRequestData;

  factory SideJobRequestData.fromJson(Map<String, dynamic> json) =>
      _$SideJobRequestDataFromJson(json);
}


