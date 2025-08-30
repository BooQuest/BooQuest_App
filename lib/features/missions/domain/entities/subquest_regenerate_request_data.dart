import 'package:freezed_annotation/freezed_annotation.dart';

part 'subquest_regenerate_request_data.freezed.dart';
part 'subquest_regenerate_request_data.g.dart';

/// 부퀘스트 재생성 요청 데이터
@freezed
class SubQuestRegenerateRequestData with _$SubQuestRegenerateRequestData {
  const factory SubQuestRegenerateRequestData({
    required FeedbackData feedbackData,
    required GenerateMissionStep generateMissionStep,
  }) = _SubQuestRegenerateRequestData;

  factory SubQuestRegenerateRequestData.fromJson(Map<String, dynamic> json) =>
      _$SubQuestRegenerateRequestDataFromJson(json);
}

/// 피드백 데이터
@freezed
class FeedbackData with _$FeedbackData {
  const factory FeedbackData({
    required List<String> reasons,
    required String etcFeedback,
  }) = _FeedbackData;

  factory FeedbackData.fromJson(Map<String, dynamic> json) =>
      _$FeedbackDataFromJson(json);
}

/// 미션 스텝 생성 데이터
@freezed
class GenerateMissionStep with _$GenerateMissionStep {
  const factory GenerateMissionStep({
    required int userId,
    required int missionId,
    required String missionTitle,
    required String missionDesignNotes,
  }) = _GenerateMissionStep;

  factory GenerateMissionStep.fromJson(Map<String, dynamic> json) =>
      _$GenerateMissionStepFromJson(json);
}
