// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_activity_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserActivitySummaryEntity _$UserActivitySummaryEntityFromJson(
  Map<String, dynamic> json,
) {
  return _UserActivitySummaryEntity.fromJson(json);
}

/// @nodoc
mixin _$UserActivitySummaryEntity {
  int get totalIncome => throw _privateConstructorUsedError;
  int get completedSideJobCount => throw _privateConstructorUsedError;
  int get completedQuestCount => throw _privateConstructorUsedError;

  /// Serializes this UserActivitySummaryEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserActivitySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserActivitySummaryEntityCopyWith<UserActivitySummaryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActivitySummaryEntityCopyWith<$Res> {
  factory $UserActivitySummaryEntityCopyWith(
    UserActivitySummaryEntity value,
    $Res Function(UserActivitySummaryEntity) then,
  ) = _$UserActivitySummaryEntityCopyWithImpl<$Res, UserActivitySummaryEntity>;
  @useResult
  $Res call({
    int totalIncome,
    int completedSideJobCount,
    int completedQuestCount,
  });
}

/// @nodoc
class _$UserActivitySummaryEntityCopyWithImpl<
  $Res,
  $Val extends UserActivitySummaryEntity
>
    implements $UserActivitySummaryEntityCopyWith<$Res> {
  _$UserActivitySummaryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserActivitySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? completedSideJobCount = null,
    Object? completedQuestCount = null,
  }) {
    return _then(
      _value.copyWith(
            totalIncome: null == totalIncome
                ? _value.totalIncome
                : totalIncome // ignore: cast_nullable_to_non_nullable
                      as int,
            completedSideJobCount: null == completedSideJobCount
                ? _value.completedSideJobCount
                : completedSideJobCount // ignore: cast_nullable_to_non_nullable
                      as int,
            completedQuestCount: null == completedQuestCount
                ? _value.completedQuestCount
                : completedQuestCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserActivitySummaryEntityImplCopyWith<$Res>
    implements $UserActivitySummaryEntityCopyWith<$Res> {
  factory _$$UserActivitySummaryEntityImplCopyWith(
    _$UserActivitySummaryEntityImpl value,
    $Res Function(_$UserActivitySummaryEntityImpl) then,
  ) = __$$UserActivitySummaryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalIncome,
    int completedSideJobCount,
    int completedQuestCount,
  });
}

/// @nodoc
class __$$UserActivitySummaryEntityImplCopyWithImpl<$Res>
    extends
        _$UserActivitySummaryEntityCopyWithImpl<
          $Res,
          _$UserActivitySummaryEntityImpl
        >
    implements _$$UserActivitySummaryEntityImplCopyWith<$Res> {
  __$$UserActivitySummaryEntityImplCopyWithImpl(
    _$UserActivitySummaryEntityImpl _value,
    $Res Function(_$UserActivitySummaryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserActivitySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? completedSideJobCount = null,
    Object? completedQuestCount = null,
  }) {
    return _then(
      _$UserActivitySummaryEntityImpl(
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as int,
        completedSideJobCount: null == completedSideJobCount
            ? _value.completedSideJobCount
            : completedSideJobCount // ignore: cast_nullable_to_non_nullable
                  as int,
        completedQuestCount: null == completedQuestCount
            ? _value.completedQuestCount
            : completedQuestCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserActivitySummaryEntityImpl implements _UserActivitySummaryEntity {
  const _$UserActivitySummaryEntityImpl({
    required this.totalIncome,
    required this.completedSideJobCount,
    required this.completedQuestCount,
  });

  factory _$UserActivitySummaryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActivitySummaryEntityImplFromJson(json);

  @override
  final int totalIncome;
  @override
  final int completedSideJobCount;
  @override
  final int completedQuestCount;

  @override
  String toString() {
    return 'UserActivitySummaryEntity(totalIncome: $totalIncome, completedSideJobCount: $completedSideJobCount, completedQuestCount: $completedQuestCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActivitySummaryEntityImpl &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.completedSideJobCount, completedSideJobCount) ||
                other.completedSideJobCount == completedSideJobCount) &&
            (identical(other.completedQuestCount, completedQuestCount) ||
                other.completedQuestCount == completedQuestCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalIncome,
    completedSideJobCount,
    completedQuestCount,
  );

  /// Create a copy of UserActivitySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActivitySummaryEntityImplCopyWith<_$UserActivitySummaryEntityImpl>
  get copyWith =>
      __$$UserActivitySummaryEntityImplCopyWithImpl<
        _$UserActivitySummaryEntityImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActivitySummaryEntityImplToJson(this);
  }
}

abstract class _UserActivitySummaryEntity implements UserActivitySummaryEntity {
  const factory _UserActivitySummaryEntity({
    required final int totalIncome,
    required final int completedSideJobCount,
    required final int completedQuestCount,
  }) = _$UserActivitySummaryEntityImpl;

  factory _UserActivitySummaryEntity.fromJson(Map<String, dynamic> json) =
      _$UserActivitySummaryEntityImpl.fromJson;

  @override
  int get totalIncome;
  @override
  int get completedSideJobCount;
  @override
  int get completedQuestCount;

  /// Create a copy of UserActivitySummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserActivitySummaryEntityImplCopyWith<_$UserActivitySummaryEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
