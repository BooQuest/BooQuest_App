import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

part 'income_state.freezed.dart';

@freezed
class IncomeState with _$IncomeState {
  const factory IncomeState.initial() = _Initial;
  const factory IncomeState.loading() = _Loading;
  const factory IncomeState.success(IncomeListEntity data) = _Success;
  const factory IncomeState.failure(String message) = _Failure;
}
