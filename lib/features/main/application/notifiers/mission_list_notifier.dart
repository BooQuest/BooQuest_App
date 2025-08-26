import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/repositories/mission_list_repository_impl.dart';

/// 미션 목록 Notifier
class MissionListNotifier extends StateNotifier<MissionListState> {
  final MissionListRepositoryImpl _repository;

  MissionListNotifier(this._repository) : super(const MissionListState.initial());

  /// 미션 목록 조회
  Future<void> getMissionList(String status) async {
    try {
      print('🔍 MissionListNotifier: getMissionList 호출 - status: $status');
      
      state = const MissionListState.loading();
      
      final result = await _repository.getMissionList(status);
      
      result.fold(
        (failure) {
          print('Notifier: Failed to get mission list data');
          state = MissionListState.failure(failure);
        },
        (data) {
          print('Notifier: Successfully got mission list data: ${data.missions.length} missions');
          state = MissionListState.success(data);
        },
      );
    } catch (e) {
      print('❌ MissionListNotifier: 예외 발생 - $e');
      state = MissionListState.failure(MainFailure.serverError());
    }
  }
}
