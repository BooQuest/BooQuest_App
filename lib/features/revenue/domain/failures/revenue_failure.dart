import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_failure.freezed.dart';

/// 수익 관련 실패
@freezed
class RevenueFailure with _$RevenueFailure {
  const factory RevenueFailure.serverError(String message) = _ServerError;
  const factory RevenueFailure.networkError(String message) = _NetworkError;
  const factory RevenueFailure.unknownError(String message) = _UnknownError;
}
