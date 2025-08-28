import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/states/update_income_state.dart';
import 'package:booquest/features/revenue/domain/usecases/update_income_usecase.dart';

/// 수익 수정 Notifier
class UpdateIncomeNotifier extends StateNotifier<UpdateIncomeState> {
  final UpdateIncomeUseCase _updateIncomeUseCase;

  UpdateIncomeNotifier(this._updateIncomeUseCase) : super(const UpdateIncomeState.initial());

  /// 수익 수정 실행
  Future<void> updateIncome({
    required int incomeId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    state = const UpdateIncomeState.loading();

    final result = await _updateIncomeUseCase(
      incomeId: incomeId,
      title: title,
      amount: amount,
      incomeDate: incomeDate,
      memo: memo,
    );

    result.fold(
      (failure) => state = UpdateIncomeState.failure(failure.message),
      (income) => state = UpdateIncomeState.success(income),
    );
  }

  /// 상태 초기화
  void reset() {
    state = const UpdateIncomeState.initial();
  }
}
