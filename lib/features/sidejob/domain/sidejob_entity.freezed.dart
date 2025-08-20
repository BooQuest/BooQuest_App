// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidejob_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SideJobEntity _$SideJobEntityFromJson(Map<String, dynamic> json) {
  return _SideJobEntity.fromJson(json);
}

/// @nodoc
mixin _$SideJobEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this SideJobEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SideJobEntityCopyWith<SideJobEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideJobEntityCopyWith<$Res> {
  factory $SideJobEntityCopyWith(
    SideJobEntity value,
    $Res Function(SideJobEntity) then,
  ) = _$SideJobEntityCopyWithImpl<$Res, SideJobEntity>;
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class _$SideJobEntityCopyWithImpl<$Res, $Val extends SideJobEntity>
    implements $SideJobEntityCopyWith<$Res> {
  _$SideJobEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SideJobEntityImplCopyWith<$Res>
    implements $SideJobEntityCopyWith<$Res> {
  factory _$$SideJobEntityImplCopyWith(
    _$SideJobEntityImpl value,
    $Res Function(_$SideJobEntityImpl) then,
  ) = __$$SideJobEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class __$$SideJobEntityImplCopyWithImpl<$Res>
    extends _$SideJobEntityCopyWithImpl<$Res, _$SideJobEntityImpl>
    implements _$$SideJobEntityImplCopyWith<$Res> {
  __$$SideJobEntityImplCopyWithImpl(
    _$SideJobEntityImpl _value,
    $Res Function(_$SideJobEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _$SideJobEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SideJobEntityImpl implements _SideJobEntity {
  const _$SideJobEntityImpl({
    required this.id,
    required this.title,
    required this.description,
  });

  factory _$SideJobEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SideJobEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'SideJobEntity(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SideJobEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  /// Create a copy of SideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SideJobEntityImplCopyWith<_$SideJobEntityImpl> get copyWith =>
      __$$SideJobEntityImplCopyWithImpl<_$SideJobEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SideJobEntityImplToJson(this);
  }
}

abstract class _SideJobEntity implements SideJobEntity {
  const factory _SideJobEntity({
    required final String id,
    required final String title,
    required final String description,
  }) = _$SideJobEntityImpl;

  factory _SideJobEntity.fromJson(Map<String, dynamic> json) =
      _$SideJobEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;

  /// Create a copy of SideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SideJobEntityImplCopyWith<_$SideJobEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SideJobRequestData _$SideJobRequestDataFromJson(Map<String, dynamic> json) {
  return _SideJobRequestData.fromJson(json);
}

/// @nodoc
mixin _$SideJobRequestData {
  int get userId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get job => throw _privateConstructorUsedError;
  List<String> get hobbies => throw _privateConstructorUsedError;
  String get expressionStyle => throw _privateConstructorUsedError;
  String get strengthType => throw _privateConstructorUsedError;
  String get characterType => throw _privateConstructorUsedError;
  String get characterName => throw _privateConstructorUsedError;

  /// Serializes this SideJobRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SideJobRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SideJobRequestDataCopyWith<SideJobRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideJobRequestDataCopyWith<$Res> {
  factory $SideJobRequestDataCopyWith(
    SideJobRequestData value,
    $Res Function(SideJobRequestData) then,
  ) = _$SideJobRequestDataCopyWithImpl<$Res, SideJobRequestData>;
  @useResult
  $Res call({
    int userId,
    String nickname,
    String job,
    List<String> hobbies,
    String expressionStyle,
    String strengthType,
    String characterType,
    String characterName,
  });
}

/// @nodoc
class _$SideJobRequestDataCopyWithImpl<$Res, $Val extends SideJobRequestData>
    implements $SideJobRequestDataCopyWith<$Res> {
  _$SideJobRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SideJobRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? nickname = null,
    Object? job = null,
    Object? hobbies = null,
    Object? expressionStyle = null,
    Object? strengthType = null,
    Object? characterType = null,
    Object? characterName = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            job: null == job
                ? _value.job
                : job // ignore: cast_nullable_to_non_nullable
                      as String,
            hobbies: null == hobbies
                ? _value.hobbies
                : hobbies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            expressionStyle: null == expressionStyle
                ? _value.expressionStyle
                : expressionStyle // ignore: cast_nullable_to_non_nullable
                      as String,
            strengthType: null == strengthType
                ? _value.strengthType
                : strengthType // ignore: cast_nullable_to_non_nullable
                      as String,
            characterType: null == characterType
                ? _value.characterType
                : characterType // ignore: cast_nullable_to_non_nullable
                      as String,
            characterName: null == characterName
                ? _value.characterName
                : characterName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SideJobRequestDataImplCopyWith<$Res>
    implements $SideJobRequestDataCopyWith<$Res> {
  factory _$$SideJobRequestDataImplCopyWith(
    _$SideJobRequestDataImpl value,
    $Res Function(_$SideJobRequestDataImpl) then,
  ) = __$$SideJobRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String nickname,
    String job,
    List<String> hobbies,
    String expressionStyle,
    String strengthType,
    String characterType,
    String characterName,
  });
}

/// @nodoc
class __$$SideJobRequestDataImplCopyWithImpl<$Res>
    extends _$SideJobRequestDataCopyWithImpl<$Res, _$SideJobRequestDataImpl>
    implements _$$SideJobRequestDataImplCopyWith<$Res> {
  __$$SideJobRequestDataImplCopyWithImpl(
    _$SideJobRequestDataImpl _value,
    $Res Function(_$SideJobRequestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? nickname = null,
    Object? job = null,
    Object? hobbies = null,
    Object? expressionStyle = null,
    Object? strengthType = null,
    Object? characterType = null,
    Object? characterName = null,
  }) {
    return _then(
      _$SideJobRequestDataImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        job: null == job
            ? _value.job
            : job // ignore: cast_nullable_to_non_nullable
                  as String,
        hobbies: null == hobbies
            ? _value._hobbies
            : hobbies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        expressionStyle: null == expressionStyle
            ? _value.expressionStyle
            : expressionStyle // ignore: cast_nullable_to_non_nullable
                  as String,
        strengthType: null == strengthType
            ? _value.strengthType
            : strengthType // ignore: cast_nullable_to_non_nullable
                  as String,
        characterType: null == characterType
            ? _value.characterType
            : characterType // ignore: cast_nullable_to_non_nullable
                  as String,
        characterName: null == characterName
            ? _value.characterName
            : characterName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SideJobRequestDataImpl implements _SideJobRequestData {
  const _$SideJobRequestDataImpl({
    required this.userId,
    required this.nickname,
    required this.job,
    required final List<String> hobbies,
    required this.expressionStyle,
    required this.strengthType,
    required this.characterType,
    required this.characterName,
  }) : _hobbies = hobbies;

  factory _$SideJobRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SideJobRequestDataImplFromJson(json);

  @override
  final int userId;
  @override
  final String nickname;
  @override
  final String job;
  final List<String> _hobbies;
  @override
  List<String> get hobbies {
    if (_hobbies is EqualUnmodifiableListView) return _hobbies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hobbies);
  }

  @override
  final String expressionStyle;
  @override
  final String strengthType;
  @override
  final String characterType;
  @override
  final String characterName;

  @override
  String toString() {
    return 'SideJobRequestData(userId: $userId, nickname: $nickname, job: $job, hobbies: $hobbies, expressionStyle: $expressionStyle, strengthType: $strengthType, characterType: $characterType, characterName: $characterName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SideJobRequestDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.job, job) || other.job == job) &&
            const DeepCollectionEquality().equals(other._hobbies, _hobbies) &&
            (identical(other.expressionStyle, expressionStyle) ||
                other.expressionStyle == expressionStyle) &&
            (identical(other.strengthType, strengthType) ||
                other.strengthType == strengthType) &&
            (identical(other.characterType, characterType) ||
                other.characterType == characterType) &&
            (identical(other.characterName, characterName) ||
                other.characterName == characterName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    nickname,
    job,
    const DeepCollectionEquality().hash(_hobbies),
    expressionStyle,
    strengthType,
    characterType,
    characterName,
  );

  /// Create a copy of SideJobRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SideJobRequestDataImplCopyWith<_$SideJobRequestDataImpl> get copyWith =>
      __$$SideJobRequestDataImplCopyWithImpl<_$SideJobRequestDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SideJobRequestDataImplToJson(this);
  }
}

abstract class _SideJobRequestData implements SideJobRequestData {
  const factory _SideJobRequestData({
    required final int userId,
    required final String nickname,
    required final String job,
    required final List<String> hobbies,
    required final String expressionStyle,
    required final String strengthType,
    required final String characterType,
    required final String characterName,
  }) = _$SideJobRequestDataImpl;

  factory _SideJobRequestData.fromJson(Map<String, dynamic> json) =
      _$SideJobRequestDataImpl.fromJson;

  @override
  int get userId;
  @override
  String get nickname;
  @override
  String get job;
  @override
  List<String> get hobbies;
  @override
  String get expressionStyle;
  @override
  String get strengthType;
  @override
  String get characterType;
  @override
  String get characterName;

  /// Create a copy of SideJobRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SideJobRequestDataImplCopyWith<_$SideJobRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
