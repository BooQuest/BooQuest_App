import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/income_repository_impl.dart';
import 'package:booquest/features/revenue/application/states/income_state.dart';

/// 수익 Notifier - Clean Architecture + Riverpod 구조
class IncomeNotifier extends StateNotifier<IncomeState> {
  final IncomeRepositoryImpl _repository;

  IncomeNotifier(this._repository) : super(const IncomeState.initial());

  /// 수익 목록 조회
  Future<void> getIncomeList(int userSideJobId) async {
    try {
      state = const IncomeState.loading();
      
      final result = await _repository.getIncomeList(userSideJobId);
      
      result.fold(
        (failure) {
          print('Notifier: Error getting income list: $failure');
          state = IncomeState.failure(failure.toString());
        },
        (incomeList) {
          print('Notifier: Successfully got income list data');
          state = IncomeState.success(incomeList);
        },
      );
    } catch (e) {
      print('Notifier: Unexpected error getting income list: $e');
      state = IncomeState.failure(e.toString());
    }
  }
}
