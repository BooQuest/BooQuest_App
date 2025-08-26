import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidejob_progress_entity.freezed.dart';
part 'sidejob_progress_entity.g.dart';

/// 사이드잡 진행률 엔티티 (필요한 데이터만 추출)
@freezed
class SideJobProgressEntity with _$SideJobProgressEntity {
  const factory SideJobProgressEntity({
    required String title,
    required int progressPercent,
    required int currentOrder,
    required int totalStages,
  }) = _SideJobProgressEntity;

  factory SideJobProgressEntity.fromJson(Map<String, dynamic> json) =>
      _$SideJobProgressEntityFromJson(json);
}
