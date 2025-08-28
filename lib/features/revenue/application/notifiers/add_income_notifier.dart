import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/add_income_repository_impl.dart';
import 'package:booquest/features/revenue/application/states/add_income_state.dart';

/// 수익 추가 Notifier - Clean Architecture + Riverpod 구조
class AddIncomeNotifier extends StateNotifier<AddIncomeState> {
  final AddIncomeRepositoryImpl _repository;

  AddIncomeNotifier(this._repository) : super(const AddIncomeState.initial());

  /// 수익 추가
  Future<void> addIncome({
    required int userSideJobId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    try {
      state = const AddIncomeState.loading();
      
      final result = await _repository.addIncome(
        userSideJobId: userSideJobId,
        title: title,
        amount: amount,
        incomeDate: incomeDate,
        memo: memo,
      );
      
      result.fold(
        (failure) {
          print('Notifier: Error adding income: $failure');
          state = AddIncomeState.failure(failure.toString());
        },
        (income) {
          print('Notifier: Successfully added income');
          state = AddIncomeState.success(income);
        },
      );
    } catch (e) {
      print('Notifier: Unexpected error adding income: $e');
      state = AddIncomeState.failure(e.toString());
    }
  }

  /// 상태 초기화
  void reset() {
    state = const AddIncomeState.initial();
  }
}
