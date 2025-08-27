import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_activity_summary_entity.freezed.dart';
part 'user_activity_summary_entity.g.dart';

/// 사용자 활동 요약 엔티티
@freezed
class UserActivitySummaryEntity with _$UserActivitySummaryEntity {
  const factory UserActivitySummaryEntity({
    required int totalIncome,
    required int completedSideJobCount,
    required int completedQuestCount,
  }) = _UserActivitySummaryEntity;

  factory UserActivitySummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$UserActivitySummaryEntityFromJson(json);
}
