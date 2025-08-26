import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/character_growth_entity.dart';
import '../../domain/failures/main_failure.dart';

part 'character_growth_state.freezed.dart';

/// 캐릭터 성장 상태
@freezed
class CharacterGrowthState with _$CharacterGrowthState {
  const factory CharacterGrowthState.initial() = Initial;
  const factory CharacterGrowthState.loading() = Loading;
  const factory CharacterGrowthState.success({
    required CharacterGrowthEntity data,
  }) = Success;
  const factory CharacterGrowthState.failure({
    required MainFailure failure,
  }) = Failure;
}
