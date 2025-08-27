import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/states/user_sidejob_list_state.dart';
import 'package:booquest/features/main/domain/entities/user_sidejob_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/repositories/user_sidejob_list_repository_impl.dart';

/// 사용자 사이드잡 목록 Notifier
class UserSideJobListNotifier extends StateNotifier<UserSideJobListState> {
  final UserSideJobListRepositoryImpl _repository;

  UserSideJobListNotifier(this._repository) : super(const UserSideJobListState.initial());

  /// 사용자 사이드잡 목록 데이터 조회
  Future<void> getUserSideJobList() async {
    state = const UserSideJobListState.loading();
    
    final result = await _repository.getUserSideJobList();
    
    result.fold(
      (failure) {
        print('Notifier: Failed to get user side job list data');
        state = UserSideJobListState.failure(failure);
      },
      (data) {
        print('Notifier: Successfully got user side job list data');
        state = UserSideJobListState.success(data);
      },
    );
  }
}
