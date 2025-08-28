import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/notifiers/update_income_notifier.dart';
import 'package:booquest/features/revenue/application/states/update_income_state.dart';
import 'package:booquest/features/revenue/domain/repositories/update_income_repository.dart';
import 'package:booquest/features/revenue/domain/usecases/update_income_usecase.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/update_income_repository_impl.dart';

/// UpdateIncomeRepository Provider
final updateIncomeRepositoryProvider = Provider<UpdateIncomeRepository>((ref) {
  return UpdateIncomeRepositoryImpl();
});

/// UpdateIncomeUseCase Provider
final updateIncomeUseCaseProvider = Provider<UpdateIncomeUseCase>((ref) {
  final repository = ref.watch(updateIncomeRepositoryProvider);
  return UpdateIncomeUseCase(repository);
});

/// UpdateIncomeNotifier Provider
final updateIncomeNotifierProvider = StateNotifierProvider<UpdateIncomeNotifier, UpdateIncomeState>((ref) {
  final useCase = ref.watch(updateIncomeUseCaseProvider);
  return UpdateIncomeNotifier(useCase);
});
