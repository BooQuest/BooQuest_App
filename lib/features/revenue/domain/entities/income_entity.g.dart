// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomeEntityImpl _$$IncomeEntityImplFromJson(Map<String, dynamic> json) =>
    _$IncomeEntityImpl(
      id: (json['id'] as num).toInt(),
      userSideJobId: (json['userSideJobId'] as num).toInt(),
      title: json['title'] as String,
      amount: (json['amount'] as num).toInt(),
      incomeDate: json['incomeDate'] as String,
      memo: json['memo'] as String,
      cumulativeAmount: (json['cumulativeAmount'] as num).toInt(),
    );

Map<String, dynamic> _$$IncomeEntityImplToJson(_$IncomeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userSideJobId': instance.userSideJobId,
      'title': instance.title,
      'amount': instance.amount,
      'incomeDate': instance.incomeDate,
      'memo': instance.memo,
      'cumulativeAmount': instance.cumulativeAmount,
    };

_$IncomeListEntityImpl _$$IncomeListEntityImplFromJson(
  Map<String, dynamic> json,
) => _$IncomeListEntityImpl(
  incomes: (json['incomes'] as List<dynamic>)
      .map((e) => IncomeEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  totalAmount: (json['totalAmount'] as num).toInt(),
);

Map<String, dynamic> _$$IncomeListEntityImplToJson(
  _$IncomeListEntityImpl instance,
) => <String, dynamic>{
  'incomes': instance.incomes,
  'totalCount': instance.totalCount,
  'totalAmount': instance.totalAmount,
};
