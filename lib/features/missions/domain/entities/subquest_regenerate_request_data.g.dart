// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subquest_regenerate_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubQuestRegenerateRequestDataImpl
_$$SubQuestRegenerateRequestDataImplFromJson(Map<String, dynamic> json) =>
    _$SubQuestRegenerateRequestDataImpl(
      feedbackData: FeedbackData.fromJson(
        json['feedbackData'] as Map<String, dynamic>,
      ),
      generateMissionStep: GenerateMissionStep.fromJson(
        json['generateMissionStep'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$SubQuestRegenerateRequestDataImplToJson(
  _$SubQuestRegenerateRequestDataImpl instance,
) => <String, dynamic>{
  'feedbackData': instance.feedbackData,
  'generateMissionStep': instance.generateMissionStep,
};

_$FeedbackDataImpl _$$FeedbackDataImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackDataImpl(
      reasons: (json['reasons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      etcFeedback: json['etcFeedback'] as String,
    );

Map<String, dynamic> _$$FeedbackDataImplToJson(_$FeedbackDataImpl instance) =>
    <String, dynamic>{
      'reasons': instance.reasons,
      'etcFeedback': instance.etcFeedback,
    };

_$GenerateMissionStepImpl _$$GenerateMissionStepImplFromJson(
  Map<String, dynamic> json,
) => _$GenerateMissionStepImpl(
  userId: (json['userId'] as num).toInt(),
  missionId: (json['missionId'] as num).toInt(),
  missionTitle: json['missionTitle'] as String,
  missionDesignNotes: json['missionDesignNotes'] as String,
);

Map<String, dynamic> _$$GenerateMissionStepImplToJson(
  _$GenerateMissionStepImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'missionId': instance.missionId,
  'missionTitle': instance.missionTitle,
  'missionDesignNotes': instance.missionDesignNotes,
};
