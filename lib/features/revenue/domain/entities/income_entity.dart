import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_entity.freezed.dart';
part 'income_entity.g.dart';

@freezed
class IncomeEntity with _$IncomeEntity {
  const factory IncomeEntity({
    required int id,
    required int userSideJobId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
    required int cumulativeAmount,
  }) = _IncomeEntity;

  factory IncomeEntity.fromJson(Map<String, dynamic> json) => _$IncomeEntityFromJson(json);
}

@freezed
class IncomeListEntity with _$IncomeListEntity {
  const factory IncomeListEntity({
    required List<IncomeEntity> incomes,
    required int totalCount,
    required int totalAmount,
  }) = _IncomeListEntity;

  factory IncomeListEntity.fromJson(Map<String, dynamic> json) => _$IncomeListEntityFromJson(json);
}
