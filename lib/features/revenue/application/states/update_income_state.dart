import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

part 'update_income_state.freezed.dart';

/// 수익 수정 상태
@freezed
class UpdateIncomeState with _$UpdateIncomeState {
  const factory UpdateIncomeState.initial() = _Initial;
  const factory UpdateIncomeState.loading() = _Loading;
  const factory UpdateIncomeState.success(IncomeEntity income) = _Success;
  const factory UpdateIncomeState.failure(String message) = _Failure;
}
