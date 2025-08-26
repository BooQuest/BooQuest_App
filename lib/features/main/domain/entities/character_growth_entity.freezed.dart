// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_growth_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CharacterGrowthEntity _$CharacterGrowthEntityFromJson(
  Map<String, dynamic> json,
) {
  return _CharacterGrowthEntity.fromJson(json);
}

/// @nodoc
mixin _$CharacterGrowthEntity {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get remainingExpToLevelUp => throw _privateConstructorUsedError;
  int get currentExp => throw _privateConstructorUsedError;
  int get requiredExpForNextLevel => throw _privateConstructorUsedError;

  /// Serializes this CharacterGrowthEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterGrowthEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterGrowthEntityCopyWith<CharacterGrowthEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterGrowthEntityCopyWith<$Res> {
  factory $CharacterGrowthEntityCopyWith(
    CharacterGrowthEntity value,
    $Res Function(CharacterGrowthEntity) then,
  ) = _$CharacterGrowthEntityCopyWithImpl<$Res, CharacterGrowthEntity>;
  @useResult
  $Res call({
    String name,
    String type,
    int level,
    int remainingExpToLevelUp,
    int currentExp,
    int requiredExpForNextLevel,
  });
}

/// @nodoc
class _$CharacterGrowthEntityCopyWithImpl<
  $Res,
  $Val extends CharacterGrowthEntity
>
    implements $CharacterGrowthEntityCopyWith<$Res> {
  _$CharacterGrowthEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterGrowthEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? level = null,
    Object? remainingExpToLevelUp = null,
    Object? currentExp = null,
    Object? requiredExpForNextLevel = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingExpToLevelUp: null == remainingExpToLevelUp
                ? _value.remainingExpToLevelUp
                : remainingExpToLevelUp // ignore: cast_nullable_to_non_nullable
                      as int,
            currentExp: null == currentExp
                ? _value.currentExp
                : currentExp // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredExpForNextLevel: null == requiredExpForNextLevel
                ? _value.requiredExpForNextLevel
                : requiredExpForNextLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterGrowthEntityImplCopyWith<$Res>
    implements $CharacterGrowthEntityCopyWith<$Res> {
  factory _$$CharacterGrowthEntityImplCopyWith(
    _$CharacterGrowthEntityImpl value,
    $Res Function(_$CharacterGrowthEntityImpl) then,
  ) = __$$CharacterGrowthEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String type,
    int level,
    int remainingExpToLevelUp,
    int currentExp,
    int requiredExpForNextLevel,
  });
}

/// @nodoc
class __$$CharacterGrowthEntityImplCopyWithImpl<$Res>
    extends
        _$CharacterGrowthEntityCopyWithImpl<$Res, _$CharacterGrowthEntityImpl>
    implements _$$CharacterGrowthEntityImplCopyWith<$Res> {
  __$$CharacterGrowthEntityImplCopyWithImpl(
    _$CharacterGrowthEntityImpl _value,
    $Res Function(_$CharacterGrowthEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterGrowthEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? level = null,
    Object? remainingExpToLevelUp = null,
    Object? currentExp = null,
    Object? requiredExpForNextLevel = null,
  }) {
    return _then(
      _$CharacterGrowthEntityImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingExpToLevelUp: null == remainingExpToLevelUp
            ? _value.remainingExpToLevelUp
            : remainingExpToLevelUp // ignore: cast_nullable_to_non_nullable
                  as int,
        currentExp: null == currentExp
            ? _value.currentExp
            : currentExp // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredExpForNextLevel: null == requiredExpForNextLevel
            ? _value.requiredExpForNextLevel
            : requiredExpForNextLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterGrowthEntityImpl implements _CharacterGrowthEntity {
  const _$CharacterGrowthEntityImpl({
    required this.name,
    required this.type,
    required this.level,
    required this.remainingExpToLevelUp,
    required this.currentExp,
    required this.requiredExpForNextLevel,
  });

  factory _$CharacterGrowthEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterGrowthEntityImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  @override
  final int level;
  @override
  final int remainingExpToLevelUp;
  @override
  final int currentExp;
  @override
  final int requiredExpForNextLevel;

  @override
  String toString() {
    return 'CharacterGrowthEntity(name: $name, type: $type, level: $level, remainingExpToLevelUp: $remainingExpToLevelUp, currentExp: $currentExp, requiredExpForNextLevel: $requiredExpForNextLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterGrowthEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.remainingExpToLevelUp, remainingExpToLevelUp) ||
                other.remainingExpToLevelUp == remainingExpToLevelUp) &&
            (identical(other.currentExp, currentExp) ||
                other.currentExp == currentExp) &&
            (identical(
                  other.requiredExpForNextLevel,
                  requiredExpForNextLevel,
                ) ||
                other.requiredExpForNextLevel == requiredExpForNextLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    type,
    level,
    remainingExpToLevelUp,
    currentExp,
    requiredExpForNextLevel,
  );

  /// Create a copy of CharacterGrowthEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterGrowthEntityImplCopyWith<_$CharacterGrowthEntityImpl>
  get copyWith =>
      __$$CharacterGrowthEntityImplCopyWithImpl<_$CharacterGrowthEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterGrowthEntityImplToJson(this);
  }
}

abstract class _CharacterGrowthEntity implements CharacterGrowthEntity {
  const factory _CharacterGrowthEntity({
    required final String name,
    required final String type,
    required final int level,
    required final int remainingExpToLevelUp,
    required final int currentExp,
    required final int requiredExpForNextLevel,
  }) = _$CharacterGrowthEntityImpl;

  factory _CharacterGrowthEntity.fromJson(Map<String, dynamic> json) =
      _$CharacterGrowthEntityImpl.fromJson;

  @override
  String get name;
  @override
  String get type;
  @override
  int get level;
  @override
  int get remainingExpToLevelUp;
  @override
  int get currentExp;
  @override
  int get requiredExpForNextLevel;

  /// Create a copy of CharacterGrowthEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterGrowthEntityImplCopyWith<_$CharacterGrowthEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
