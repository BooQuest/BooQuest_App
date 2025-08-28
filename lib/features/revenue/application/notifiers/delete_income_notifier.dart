import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/states/delete_income_state.dart';
import 'package:booquest/features/revenue/domain/usecases/delete_income_usecase.dart';

/// 수익 삭제 Notifier
class DeleteIncomeNotifier extends StateNotifier<DeleteIncomeState> {
  final DeleteIncomeUseCase _deleteIncomeUseCase;

  DeleteIncomeNotifier(this._deleteIncomeUseCase) : super(const DeleteIncomeState.initial());

  /// 수익 삭제 실행
  Future<void> deleteIncome(int incomeId) async {
    state = const DeleteIncomeState.loading();

    final result = await _deleteIncomeUseCase(incomeId);

    result.fold(
      (failure) => state = DeleteIncomeState.failure(failure.message),
      (_) => state = const DeleteIncomeState.success(),
    );
  }

  /// 상태 초기화
  void reset() {
    state = const DeleteIncomeState.initial();
  }
}
