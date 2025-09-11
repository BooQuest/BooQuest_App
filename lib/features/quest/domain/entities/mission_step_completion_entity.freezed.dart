// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_step_completion_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MissionStepCompletionEntity _$MissionStepCompletionEntityFromJson(
  Map<String, dynamic> json,
) {
  return _MissionStepCompletionEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionStepCompletionEntity {
  MissionStepEntity get step => throw _privateConstructorUsedError;
  CharacterEntity get character => throw _privateConstructorUsedError;
  int get expDelta => throw _privateConstructorUsedError;
  bool get leveledUp => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;

  /// Serializes this MissionStepCompletionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionStepCompletionEntityCopyWith<MissionStepCompletionEntity>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionStepCompletionEntityCopyWith<$Res> {
  factory $MissionStepCompletionEntityCopyWith(
    MissionStepCompletionEntity value,
    $Res Function(MissionStepCompletionEntity) then,
  ) =
      _$MissionStepCompletionEntityCopyWithImpl<
        $Res,
        MissionStepCompletionEntity
      >;
  @useResult
  $Res call({
    MissionStepEntity step,
    CharacterEntity character,
    int expDelta,
    bool leveledUp,
    int currentLevel,
  });

  $MissionStepEntityCopyWith<$Res> get step;
  $CharacterEntityCopyWith<$Res> get character;
}

/// @nodoc
class _$MissionStepCompletionEntityCopyWithImpl<
  $Res,
  $Val extends MissionStepCompletionEntity
>
    implements $MissionStepCompletionEntityCopyWith<$Res> {
  _$MissionStepCompletionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? character = null,
    Object? expDelta = null,
    Object? leveledUp = null,
    Object? currentLevel = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as MissionStepEntity,
            character: null == character
                ? _value.character
                : character // ignore: cast_nullable_to_non_nullable
                      as CharacterEntity,
            expDelta: null == expDelta
                ? _value.expDelta
                : expDelta // ignore: cast_nullable_to_non_nullable
                      as int,
            leveledUp: null == leveledUp
                ? _value.leveledUp
                : leveledUp // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentLevel: null == currentLevel
                ? _value.currentLevel
                : currentLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissionStepEntityCopyWith<$Res> get step {
    return $MissionStepEntityCopyWith<$Res>(_value.step, (value) {
      return _then(_value.copyWith(step: value) as $Val);
    });
  }

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterEntityCopyWith<$Res> get character {
    return $CharacterEntityCopyWith<$Res>(_value.character, (value) {
      return _then(_value.copyWith(character: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MissionStepCompletionEntityImplCopyWith<$Res>
    implements $MissionStepCompletionEntityCopyWith<$Res> {
  factory _$$MissionStepCompletionEntityImplCopyWith(
    _$MissionStepCompletionEntityImpl value,
    $Res Function(_$MissionStepCompletionEntityImpl) then,
  ) = __$$MissionStepCompletionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MissionStepEntity step,
    CharacterEntity character,
    int expDelta,
    bool leveledUp,
    int currentLevel,
  });

  @override
  $MissionStepEntityCopyWith<$Res> get step;
  @override
  $CharacterEntityCopyWith<$Res> get character;
}

/// @nodoc
class __$$MissionStepCompletionEntityImplCopyWithImpl<$Res>
    extends
        _$MissionStepCompletionEntityCopyWithImpl<
          $Res,
          _$MissionStepCompletionEntityImpl
        >
    implements _$$MissionStepCompletionEntityImplCopyWith<$Res> {
  __$$MissionStepCompletionEntityImplCopyWithImpl(
    _$MissionStepCompletionEntityImpl _value,
    $Res Function(_$MissionStepCompletionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? character = null,
    Object? expDelta = null,
    Object? leveledUp = null,
    Object? currentLevel = null,
  }) {
    return _then(
      _$MissionStepCompletionEntityImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as MissionStepEntity,
        character: null == character
            ? _value.character
            : character // ignore: cast_nullable_to_non_nullable
                  as CharacterEntity,
        expDelta: null == expDelta
            ? _value.expDelta
            : expDelta // ignore: cast_nullable_to_non_nullable
                  as int,
        leveledUp: null == leveledUp
            ? _value.leveledUp
            : leveledUp // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentLevel: null == currentLevel
            ? _value.currentLevel
            : currentLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionStepCompletionEntityImpl
    implements _MissionStepCompletionEntity {
  const _$MissionStepCompletionEntityImpl({
    required this.step,
    required this.character,
    required this.expDelta,
    this.leveledUp = false,
    this.currentLevel = 0,
  });

  factory _$MissionStepCompletionEntityImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MissionStepCompletionEntityImplFromJson(json);

  @override
  final MissionStepEntity step;
  @override
  final CharacterEntity character;
  @override
  final int expDelta;
  @override
  @JsonKey()
  final bool leveledUp;
  @override
  @JsonKey()
  final int currentLevel;

  @override
  String toString() {
    return 'MissionStepCompletionEntity(step: $step, character: $character, expDelta: $expDelta, leveledUp: $leveledUp, currentLevel: $currentLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionStepCompletionEntityImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.expDelta, expDelta) ||
                other.expDelta == expDelta) &&
            (identical(other.leveledUp, leveledUp) ||
                other.leveledUp == leveledUp) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    step,
    character,
    expDelta,
    leveledUp,
    currentLevel,
  );

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionStepCompletionEntityImplCopyWith<_$MissionStepCompletionEntityImpl>
  get copyWith =>
      __$$MissionStepCompletionEntityImplCopyWithImpl<
        _$MissionStepCompletionEntityImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionStepCompletionEntityImplToJson(this);
  }
}

abstract class _MissionStepCompletionEntity
    implements MissionStepCompletionEntity {
  const factory _MissionStepCompletionEntity({
    required final MissionStepEntity step,
    required final CharacterEntity character,
    required final int expDelta,
    final bool leveledUp,
    final int currentLevel,
  }) = _$MissionStepCompletionEntityImpl;

  factory _MissionStepCompletionEntity.fromJson(Map<String, dynamic> json) =
      _$MissionStepCompletionEntityImpl.fromJson;

  @override
  MissionStepEntity get step;
  @override
  CharacterEntity get character;
  @override
  int get expDelta;
  @override
  bool get leveledUp;
  @override
  int get currentLevel;

  /// Create a copy of MissionStepCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionStepCompletionEntityImplCopyWith<_$MissionStepCompletionEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MissionStepEntity _$MissionStepEntityFromJson(Map<String, dynamic> json) {
  return _MissionStepEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionStepEntity {
  int get id => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;

  /// Serializes this MissionStepEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionStepEntityCopyWith<MissionStepEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionStepEntityCopyWith<$Res> {
  factory $MissionStepEntityCopyWith(
    MissionStepEntity value,
    $Res Function(MissionStepEntity) then,
  ) = _$MissionStepEntityCopyWithImpl<$Res, MissionStepEntity>;
  @useResult
  $Res call({int id, int seq, String title, String status, String detail});
}

/// @nodoc
class _$MissionStepEntityCopyWithImpl<$Res, $Val extends MissionStepEntity>
    implements $MissionStepEntityCopyWith<$Res> {
  _$MissionStepEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? title = null,
    Object? status = null,
    Object? detail = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            seq: null == seq
                ? _value.seq
                : seq // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            detail: null == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionStepEntityImplCopyWith<$Res>
    implements $MissionStepEntityCopyWith<$Res> {
  factory _$$MissionStepEntityImplCopyWith(
    _$MissionStepEntityImpl value,
    $Res Function(_$MissionStepEntityImpl) then,
  ) = __$$MissionStepEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int seq, String title, String status, String detail});
}

/// @nodoc
class __$$MissionStepEntityImplCopyWithImpl<$Res>
    extends _$MissionStepEntityCopyWithImpl<$Res, _$MissionStepEntityImpl>
    implements _$$MissionStepEntityImplCopyWith<$Res> {
  __$$MissionStepEntityImplCopyWithImpl(
    _$MissionStepEntityImpl _value,
    $Res Function(_$MissionStepEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seq = null,
    Object? title = null,
    Object? status = null,
    Object? detail = null,
  }) {
    return _then(
      _$MissionStepEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        seq: null == seq
            ? _value.seq
            : seq // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        detail: null == detail
            ? _value.detail
            : detail // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionStepEntityImpl implements _MissionStepEntity {
  const _$MissionStepEntityImpl({
    required this.id,
    required this.seq,
    required this.title,
    required this.status,
    required this.detail,
  });

  factory _$MissionStepEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionStepEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int seq;
  @override
  final String title;
  @override
  final String status;
  @override
  final String detail;

  @override
  String toString() {
    return 'MissionStepEntity(id: $id, seq: $seq, title: $title, status: $status, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionStepEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, seq, title, status, detail);

  /// Create a copy of MissionStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionStepEntityImplCopyWith<_$MissionStepEntityImpl> get copyWith =>
      __$$MissionStepEntityImplCopyWithImpl<_$MissionStepEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionStepEntityImplToJson(this);
  }
}

abstract class _MissionStepEntity implements MissionStepEntity {
  const factory _MissionStepEntity({
    required final int id,
    required final int seq,
    required final String title,
    required final String status,
    required final String detail,
  }) = _$MissionStepEntityImpl;

  factory _MissionStepEntity.fromJson(Map<String, dynamic> json) =
      _$MissionStepEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get seq;
  @override
  String get title;
  @override
  String get status;
  @override
  String get detail;

  /// Create a copy of MissionStepEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionStepEntityImplCopyWith<_$MissionStepEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) {
  return _CharacterEntity.fromJson(json);
}

/// @nodoc
mixin _$CharacterEntity {
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get exp => throw _privateConstructorUsedError;
  String get characterType => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this CharacterEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterEntityCopyWith<CharacterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterEntityCopyWith<$Res> {
  factory $CharacterEntityCopyWith(
    CharacterEntity value,
    $Res Function(CharacterEntity) then,
  ) = _$CharacterEntityCopyWithImpl<$Res, CharacterEntity>;
  @useResult
  $Res call({
    int userId,
    String name,
    int level,
    int exp,
    String characterType,
    String avatarUrl,
  });
}

/// @nodoc
class _$CharacterEntityCopyWithImpl<$Res, $Val extends CharacterEntity>
    implements $CharacterEntityCopyWith<$Res> {
  _$CharacterEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? level = null,
    Object? exp = null,
    Object? characterType = null,
    Object? avatarUrl = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            exp: null == exp
                ? _value.exp
                : exp // ignore: cast_nullable_to_non_nullable
                      as int,
            characterType: null == characterType
                ? _value.characterType
                : characterType // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterEntityImplCopyWith<$Res>
    implements $CharacterEntityCopyWith<$Res> {
  factory _$$CharacterEntityImplCopyWith(
    _$CharacterEntityImpl value,
    $Res Function(_$CharacterEntityImpl) then,
  ) = __$$CharacterEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String name,
    int level,
    int exp,
    String characterType,
    String avatarUrl,
  });
}

/// @nodoc
class __$$CharacterEntityImplCopyWithImpl<$Res>
    extends _$CharacterEntityCopyWithImpl<$Res, _$CharacterEntityImpl>
    implements _$$CharacterEntityImplCopyWith<$Res> {
  __$$CharacterEntityImplCopyWithImpl(
    _$CharacterEntityImpl _value,
    $Res Function(_$CharacterEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? level = null,
    Object? exp = null,
    Object? characterType = null,
    Object? avatarUrl = null,
  }) {
    return _then(
      _$CharacterEntityImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        exp: null == exp
            ? _value.exp
            : exp // ignore: cast_nullable_to_non_nullable
                  as int,
        characterType: null == characterType
            ? _value.characterType
            : characterType // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterEntityImpl implements _CharacterEntity {
  const _$CharacterEntityImpl({
    required this.userId,
    required this.name,
    required this.level,
    required this.exp,
    required this.characterType,
    required this.avatarUrl,
  });

  factory _$CharacterEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterEntityImplFromJson(json);

  @override
  final int userId;
  @override
  final String name;
  @override
  final int level;
  @override
  final int exp;
  @override
  final String characterType;
  @override
  final String avatarUrl;

  @override
  String toString() {
    return 'CharacterEntity(userId: $userId, name: $name, level: $level, exp: $exp, characterType: $characterType, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.characterType, characterType) ||
                other.characterType == characterType) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    name,
    level,
    exp,
    characterType,
    avatarUrl,
  );

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterEntityImplCopyWith<_$CharacterEntityImpl> get copyWith =>
      __$$CharacterEntityImplCopyWithImpl<_$CharacterEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterEntityImplToJson(this);
  }
}

abstract class _CharacterEntity implements CharacterEntity {
  const factory _CharacterEntity({
    required final int userId,
    required final String name,
    required final int level,
    required final int exp,
    required final String characterType,
    required final String avatarUrl,
  }) = _$CharacterEntityImpl;

  factory _CharacterEntity.fromJson(Map<String, dynamic> json) =
      _$CharacterEntityImpl.fromJson;

  @override
  int get userId;
  @override
  String get name;
  @override
  int get level;
  @override
  int get exp;
  @override
  String get characterType;
  @override
  String get avatarUrl;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterEntityImplCopyWith<_$CharacterEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
