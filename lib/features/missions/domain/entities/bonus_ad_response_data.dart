import 'package:freezed_annotation/freezed_annotation.dart';

part 'bonus_ad_response_data.freezed.dart';
part 'bonus_ad_response_data.g.dart';

@freezed
class BonusAdResponseData with _$BonusAdResponseData {
  const factory BonusAdResponseData({
    required bool success,
    required int status,
    required String message,
    required BonusAdData data,
  }) = _BonusAdResponseData;

  factory BonusAdResponseData.fromJson(Map<String, dynamic> json) =>
      _$BonusAdResponseDataFromJson(json);
}

@freezed
class BonusAdData with _$BonusAdData {
  const factory BonusAdData({
    required String status,
    required int additionalExp,
    required int totalStepExp,
    required bool leveledUp,
    required int currentLevel,
  }) = _BonusAdData;

  factory BonusAdData.fromJson(Map<String, dynamic> json) =>
      _$BonusAdDataFromJson(json);
}
