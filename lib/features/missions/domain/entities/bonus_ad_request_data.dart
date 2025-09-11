import 'package:freezed_annotation/freezed_annotation.dart';

part 'bonus_ad_request_data.freezed.dart';
part 'bonus_ad_request_data.g.dart';

@freezed
class BonusAdRequestData with _$BonusAdRequestData {
  const factory BonusAdRequestData({
    required String receipt,
    required String adSessionId,
  }) = _BonusAdRequestData;

  factory BonusAdRequestData.fromJson(Map<String, dynamic> json) =>
      _$BonusAdRequestDataFromJson(json);
}
