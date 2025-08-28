import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/add_income_repository_impl.dart';
import 'package:booquest/features/revenue/application/notifiers/add_income_notifier.dart';
import 'package:booquest/features/revenue/application/states/add_income_state.dart';

/// 수익 추가 Repository Provider
final addIncomeRepositoryProvider = Provider<AddIncomeRepositoryImpl>((ref) {
  return AddIncomeRepositoryImpl();
});

/// 수익 추가 Notifier Provider
final addIncomeNotifierProvider = StateNotifierProvider<AddIncomeNotifier, AddIncomeState>((ref) {
  final repository = ref.watch(addIncomeRepositoryProvider);
  return AddIncomeNotifier(repository);
});
