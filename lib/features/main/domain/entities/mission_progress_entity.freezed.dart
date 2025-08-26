// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MissionProgressEntity _$MissionProgressEntityFromJson(
  Map<String, dynamic> json,
) {
  return _MissionProgressEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionProgressEntity {
  int get currentMissionId => throw _privateConstructorUsedError;
  int get currentMissionOrder => throw _privateConstructorUsedError;
  String get currentMissionTitle => throw _privateConstructorUsedError;
  double get missionStepProgressPercentage =>
      throw _privateConstructorUsedError;

  /// Serializes this MissionProgressEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionProgressEntityCopyWith<MissionProgressEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionProgressEntityCopyWith<$Res> {
  factory $MissionProgressEntityCopyWith(
    MissionProgressEntity value,
    $Res Function(MissionProgressEntity) then,
  ) = _$MissionProgressEntityCopyWithImpl<$Res, MissionProgressEntity>;
  @useResult
  $Res call({
    int currentMissionId,
    int currentMissionOrder,
    String currentMissionTitle,
    double missionStepProgressPercentage,
  });
}

/// @nodoc
class _$MissionProgressEntityCopyWithImpl<
  $Res,
  $Val extends MissionProgressEntity
>
    implements $MissionProgressEntityCopyWith<$Res> {
  _$MissionProgressEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMissionId = null,
    Object? currentMissionOrder = null,
    Object? currentMissionTitle = null,
    Object? missionStepProgressPercentage = null,
  }) {
    return _then(
      _value.copyWith(
            currentMissionId: null == currentMissionId
                ? _value.currentMissionId
                : currentMissionId // ignore: cast_nullable_to_non_nullable
                      as int,
            currentMissionOrder: null == currentMissionOrder
                ? _value.currentMissionOrder
                : currentMissionOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            currentMissionTitle: null == currentMissionTitle
                ? _value.currentMissionTitle
                : currentMissionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            missionStepProgressPercentage: null == missionStepProgressPercentage
                ? _value.missionStepProgressPercentage
                : missionStepProgressPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionProgressEntityImplCopyWith<$Res>
    implements $MissionProgressEntityCopyWith<$Res> {
  factory _$$MissionProgressEntityImplCopyWith(
    _$MissionProgressEntityImpl value,
    $Res Function(_$MissionProgressEntityImpl) then,
  ) = __$$MissionProgressEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentMissionId,
    int currentMissionOrder,
    String currentMissionTitle,
    double missionStepProgressPercentage,
  });
}

/// @nodoc
class __$$MissionProgressEntityImplCopyWithImpl<$Res>
    extends
        _$MissionProgressEntityCopyWithImpl<$Res, _$MissionProgressEntityImpl>
    implements _$$MissionProgressEntityImplCopyWith<$Res> {
  __$$MissionProgressEntityImplCopyWithImpl(
    _$MissionProgressEntityImpl _value,
    $Res Function(_$MissionProgressEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMissionId = null,
    Object? currentMissionOrder = null,
    Object? currentMissionTitle = null,
    Object? missionStepProgressPercentage = null,
  }) {
    return _then(
      _$MissionProgressEntityImpl(
        currentMissionId: null == currentMissionId
            ? _value.currentMissionId
            : currentMissionId // ignore: cast_nullable_to_non_nullable
                  as int,
        currentMissionOrder: null == currentMissionOrder
            ? _value.currentMissionOrder
            : currentMissionOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        currentMissionTitle: null == currentMissionTitle
            ? _value.currentMissionTitle
            : currentMissionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        missionStepProgressPercentage: null == missionStepProgressPercentage
            ? _value.missionStepProgressPercentage
            : missionStepProgressPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionProgressEntityImpl implements _MissionProgressEntity {
  const _$MissionProgressEntityImpl({
    required this.currentMissionId,
    required this.currentMissionOrder,
    required this.currentMissionTitle,
    required this.missionStepProgressPercentage,
  });

  factory _$MissionProgressEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionProgressEntityImplFromJson(json);

  @override
  final int currentMissionId;
  @override
  final int currentMissionOrder;
  @override
  final String currentMissionTitle;
  @override
  final double missionStepProgressPercentage;

  @override
  String toString() {
    return 'MissionProgressEntity(currentMissionId: $currentMissionId, currentMissionOrder: $currentMissionOrder, currentMissionTitle: $currentMissionTitle, missionStepProgressPercentage: $missionStepProgressPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionProgressEntityImpl &&
            (identical(other.currentMissionId, currentMissionId) ||
                other.currentMissionId == currentMissionId) &&
            (identical(other.currentMissionOrder, currentMissionOrder) ||
                other.currentMissionOrder == currentMissionOrder) &&
            (identical(other.currentMissionTitle, currentMissionTitle) ||
                other.currentMissionTitle == currentMissionTitle) &&
            (identical(
                  other.missionStepProgressPercentage,
                  missionStepProgressPercentage,
                ) ||
                other.missionStepProgressPercentage ==
                    missionStepProgressPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentMissionId,
    currentMissionOrder,
    currentMissionTitle,
    missionStepProgressPercentage,
  );

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionProgressEntityImplCopyWith<_$MissionProgressEntityImpl>
  get copyWith =>
      __$$MissionProgressEntityImplCopyWithImpl<_$MissionProgressEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionProgressEntityImplToJson(this);
  }
}

abstract class _MissionProgressEntity implements MissionProgressEntity {
  const factory _MissionProgressEntity({
    required final int currentMissionId,
    required final int currentMissionOrder,
    required final String currentMissionTitle,
    required final double missionStepProgressPercentage,
  }) = _$MissionProgressEntityImpl;

  factory _MissionProgressEntity.fromJson(Map<String, dynamic> json) =
      _$MissionProgressEntityImpl.fromJson;

  @override
  int get currentMissionId;
  @override
  int get currentMissionOrder;
  @override
  String get currentMissionTitle;
  @override
  double get missionStepProgressPercentage;

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionProgressEntityImplCopyWith<_$MissionProgressEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
