import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/character_growth_state.dart';
import '../../infrastructure/repositories/character_growth_repository_impl.dart';

/// 캐릭터 성장 상태 노티파이어
class CharacterGrowthNotifier extends StateNotifier<CharacterGrowthState> {
  CharacterGrowthNotifier() : super(const CharacterGrowthState.initial());

  /// 캐릭터 성장 정보를 가져옵니다
  Future<void> getCharacterGrowth() async {
    print('Notifier: Starting to get character growth data'); // 디버깅용 print
    state = const CharacterGrowthState.loading();
    
    final repository = CharacterGrowthRepositoryImpl();
    final result = await repository.getCharacterGrowth();
    
    result.fold(
      (failure) {
        print('Notifier: Failed to get character growth data'); // 디버깅용 print
        state = CharacterGrowthState.failure(failure: failure);
      },
      (data) {
        print('Notifier: Successfully got character growth data: ${data.name} Level ${data.level}'); // 디버깅용 print
        state = CharacterGrowthState.success(data: data);
      },
    );
  }

  /// 상태를 초기화합니다
  void reset() {
    state = const CharacterGrowthState.initial();
  }
}
