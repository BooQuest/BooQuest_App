import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/income_repository_impl.dart';
import 'package:booquest/features/revenue/application/notifiers/income_notifier.dart';
import 'package:booquest/features/revenue/application/states/income_state.dart';

/// 수익 Repository Provider
final incomeRepositoryProvider = Provider<IncomeRepositoryImpl>((ref) {
  return IncomeRepositoryImpl();
});

/// 수익 Notifier Provider
final incomeNotifierProvider = StateNotifierProvider<IncomeNotifier, IncomeState>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return IncomeNotifier(repository);
});
