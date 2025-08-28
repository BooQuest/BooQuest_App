// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IncomeEntity _$IncomeEntityFromJson(Map<String, dynamic> json) {
  return _IncomeEntity.fromJson(json);
}

/// @nodoc
mixin _$IncomeEntity {
  int get id => throw _privateConstructorUsedError;
  int get userSideJobId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get incomeDate => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  int get cumulativeAmount => throw _privateConstructorUsedError;

  /// Serializes this IncomeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncomeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomeEntityCopyWith<IncomeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeEntityCopyWith<$Res> {
  factory $IncomeEntityCopyWith(
    IncomeEntity value,
    $Res Function(IncomeEntity) then,
  ) = _$IncomeEntityCopyWithImpl<$Res, IncomeEntity>;
  @useResult
  $Res call({
    int id,
    int userSideJobId,
    String title,
    int amount,
    String incomeDate,
    String memo,
    int cumulativeAmount,
  });
}

/// @nodoc
class _$IncomeEntityCopyWithImpl<$Res, $Val extends IncomeEntity>
    implements $IncomeEntityCopyWith<$Res> {
  _$IncomeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userSideJobId = null,
    Object? title = null,
    Object? amount = null,
    Object? incomeDate = null,
    Object? memo = null,
    Object? cumulativeAmount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userSideJobId: null == userSideJobId
                ? _value.userSideJobId
                : userSideJobId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            incomeDate: null == incomeDate
                ? _value.incomeDate
                : incomeDate // ignore: cast_nullable_to_non_nullable
                      as String,
            memo: null == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String,
            cumulativeAmount: null == cumulativeAmount
                ? _value.cumulativeAmount
                : cumulativeAmount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncomeEntityImplCopyWith<$Res>
    implements $IncomeEntityCopyWith<$Res> {
  factory _$$IncomeEntityImplCopyWith(
    _$IncomeEntityImpl value,
    $Res Function(_$IncomeEntityImpl) then,
  ) = __$$IncomeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userSideJobId,
    String title,
    int amount,
    String incomeDate,
    String memo,
    int cumulativeAmount,
  });
}

/// @nodoc
class __$$IncomeEntityImplCopyWithImpl<$Res>
    extends _$IncomeEntityCopyWithImpl<$Res, _$IncomeEntityImpl>
    implements _$$IncomeEntityImplCopyWith<$Res> {
  __$$IncomeEntityImplCopyWithImpl(
    _$IncomeEntityImpl _value,
    $Res Function(_$IncomeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncomeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userSideJobId = null,
    Object? title = null,
    Object? amount = null,
    Object? incomeDate = null,
    Object? memo = null,
    Object? cumulativeAmount = null,
  }) {
    return _then(
      _$IncomeEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userSideJobId: null == userSideJobId
            ? _value.userSideJobId
            : userSideJobId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        incomeDate: null == incomeDate
            ? _value.incomeDate
            : incomeDate // ignore: cast_nullable_to_non_nullable
                  as String,
        memo: null == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String,
        cumulativeAmount: null == cumulativeAmount
            ? _value.cumulativeAmount
            : cumulativeAmount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncomeEntityImpl implements _IncomeEntity {
  const _$IncomeEntityImpl({
    required this.id,
    required this.userSideJobId,
    required this.title,
    required this.amount,
    required this.incomeDate,
    required this.memo,
    required this.cumulativeAmount,
  });

  factory _$IncomeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncomeEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int userSideJobId;
  @override
  final String title;
  @override
  final int amount;
  @override
  final String incomeDate;
  @override
  final String memo;
  @override
  final int cumulativeAmount;

  @override
  String toString() {
    return 'IncomeEntity(id: $id, userSideJobId: $userSideJobId, title: $title, amount: $amount, incomeDate: $incomeDate, memo: $memo, cumulativeAmount: $cumulativeAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userSideJobId, userSideJobId) ||
                other.userSideJobId == userSideJobId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.incomeDate, incomeDate) ||
                other.incomeDate == incomeDate) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.cumulativeAmount, cumulativeAmount) ||
                other.cumulativeAmount == cumulativeAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userSideJobId,
    title,
    amount,
    incomeDate,
    memo,
    cumulativeAmount,
  );

  /// Create a copy of IncomeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeEntityImplCopyWith<_$IncomeEntityImpl> get copyWith =>
      __$$IncomeEntityImplCopyWithImpl<_$IncomeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncomeEntityImplToJson(this);
  }
}

abstract class _IncomeEntity implements IncomeEntity {
  const factory _IncomeEntity({
    required final int id,
    required final int userSideJobId,
    required final String title,
    required final int amount,
    required final String incomeDate,
    required final String memo,
    required final int cumulativeAmount,
  }) = _$IncomeEntityImpl;

  factory _IncomeEntity.fromJson(Map<String, dynamic> json) =
      _$IncomeEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get userSideJobId;
  @override
  String get title;
  @override
  int get amount;
  @override
  String get incomeDate;
  @override
  String get memo;
  @override
  int get cumulativeAmount;

  /// Create a copy of IncomeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomeEntityImplCopyWith<_$IncomeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncomeListEntity _$IncomeListEntityFromJson(Map<String, dynamic> json) {
  return _IncomeListEntity.fromJson(json);
}

/// @nodoc
mixin _$IncomeListEntity {
  List<IncomeEntity> get incomes => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;

  /// Serializes this IncomeListEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncomeListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomeListEntityCopyWith<IncomeListEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeListEntityCopyWith<$Res> {
  factory $IncomeListEntityCopyWith(
    IncomeListEntity value,
    $Res Function(IncomeListEntity) then,
  ) = _$IncomeListEntityCopyWithImpl<$Res, IncomeListEntity>;
  @useResult
  $Res call({List<IncomeEntity> incomes, int totalCount, int totalAmount});
}

/// @nodoc
class _$IncomeListEntityCopyWithImpl<$Res, $Val extends IncomeListEntity>
    implements $IncomeListEntityCopyWith<$Res> {
  _$IncomeListEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomeListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomes = null,
    Object? totalCount = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _value.copyWith(
            incomes: null == incomes
                ? _value.incomes
                : incomes // ignore: cast_nullable_to_non_nullable
                      as List<IncomeEntity>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncomeListEntityImplCopyWith<$Res>
    implements $IncomeListEntityCopyWith<$Res> {
  factory _$$IncomeListEntityImplCopyWith(
    _$IncomeListEntityImpl value,
    $Res Function(_$IncomeListEntityImpl) then,
  ) = __$$IncomeListEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IncomeEntity> incomes, int totalCount, int totalAmount});
}

/// @nodoc
class __$$IncomeListEntityImplCopyWithImpl<$Res>
    extends _$IncomeListEntityCopyWithImpl<$Res, _$IncomeListEntityImpl>
    implements _$$IncomeListEntityImplCopyWith<$Res> {
  __$$IncomeListEntityImplCopyWithImpl(
    _$IncomeListEntityImpl _value,
    $Res Function(_$IncomeListEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncomeListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomes = null,
    Object? totalCount = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _$IncomeListEntityImpl(
        incomes: null == incomes
            ? _value._incomes
            : incomes // ignore: cast_nullable_to_non_nullable
                  as List<IncomeEntity>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncomeListEntityImpl implements _IncomeListEntity {
  const _$IncomeListEntityImpl({
    required final List<IncomeEntity> incomes,
    required this.totalCount,
    required this.totalAmount,
  }) : _incomes = incomes;

  factory _$IncomeListEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncomeListEntityImplFromJson(json);

  final List<IncomeEntity> _incomes;
  @override
  List<IncomeEntity> get incomes {
    if (_incomes is EqualUnmodifiableListView) return _incomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomes);
  }

  @override
  final int totalCount;
  @override
  final int totalAmount;

  @override
  String toString() {
    return 'IncomeListEntity(incomes: $incomes, totalCount: $totalCount, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeListEntityImpl &&
            const DeepCollectionEquality().equals(other._incomes, _incomes) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_incomes),
    totalCount,
    totalAmount,
  );

  /// Create a copy of IncomeListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeListEntityImplCopyWith<_$IncomeListEntityImpl> get copyWith =>
      __$$IncomeListEntityImplCopyWithImpl<_$IncomeListEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IncomeListEntityImplToJson(this);
  }
}

abstract class _IncomeListEntity implements IncomeListEntity {
  const factory _IncomeListEntity({
    required final List<IncomeEntity> incomes,
    required final int totalCount,
    required final int totalAmount,
  }) = _$IncomeListEntityImpl;

  factory _IncomeListEntity.fromJson(Map<String, dynamic> json) =
      _$IncomeListEntityImpl.fromJson;

  @override
  List<IncomeEntity> get incomes;
  @override
  int get totalCount;
  @override
  int get totalAmount;

  /// Create a copy of IncomeListEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomeListEntityImplCopyWith<_$IncomeListEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
