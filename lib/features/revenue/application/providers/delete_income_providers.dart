import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/notifiers/delete_income_notifier.dart';
import 'package:booquest/features/revenue/application/states/delete_income_state.dart';
import 'package:booquest/features/revenue/domain/repositories/delete_income_repository.dart';
import 'package:booquest/features/revenue/domain/usecases/delete_income_usecase.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/delete_income_repository_impl.dart';

/// DeleteIncomeRepository Provider
final deleteIncomeRepositoryProvider = Provider<DeleteIncomeRepository>((ref) {
  return DeleteIncomeRepositoryImpl();
});

/// DeleteIncomeUseCase Provider
final deleteIncomeUseCaseProvider = Provider<DeleteIncomeUseCase>((ref) {
  final repository = ref.watch(deleteIncomeRepositoryProvider);
  return DeleteIncomeUseCase(repository);
});

/// DeleteIncomeNotifier Provider
final deleteIncomeNotifierProvider = StateNotifierProvider<DeleteIncomeNotifier, DeleteIncomeState>((ref) {
  final useCase = ref.watch(deleteIncomeUseCaseProvider);
  return DeleteIncomeNotifier(useCase);
});
