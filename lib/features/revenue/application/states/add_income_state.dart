import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

part 'add_income_state.freezed.dart';

@freezed
class AddIncomeState with _$AddIncomeState {
  const factory AddIncomeState.initial() = _Initial;
  const factory AddIncomeState.loading() = _Loading;
  const factory AddIncomeState.success(IncomeEntity data) = _Success;
  const factory AddIncomeState.failure(String message) = _Failure;
}
