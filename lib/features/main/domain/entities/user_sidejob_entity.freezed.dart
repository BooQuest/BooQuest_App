// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_sidejob_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSideJobEntity _$UserSideJobEntityFromJson(Map<String, dynamic> json) {
  return _UserSideJobEntity.fromJson(json);
}

/// @nodoc
mixin _$UserSideJobEntity {
  int get id => throw _privateConstructorUsedError;
  int get sideJobId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get startedAt => throw _privateConstructorUsedError;
  String? get endedAt => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;

  /// Serializes this UserSideJobEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSideJobEntityCopyWith<UserSideJobEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSideJobEntityCopyWith<$Res> {
  factory $UserSideJobEntityCopyWith(
    UserSideJobEntity value,
    $Res Function(UserSideJobEntity) then,
  ) = _$UserSideJobEntityCopyWithImpl<$Res, UserSideJobEntity>;
  @useResult
  $Res call({
    int id,
    int sideJobId,
    String title,
    String description,
    String status,
    String startedAt,
    String? endedAt,
    String period,
  });
}

/// @nodoc
class _$UserSideJobEntityCopyWithImpl<$Res, $Val extends UserSideJobEntity>
    implements $UserSideJobEntityCopyWith<$Res> {
  _$UserSideJobEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? period = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sideJobId: null == sideJobId
                ? _value.sideJobId
                : sideJobId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSideJobEntityImplCopyWith<$Res>
    implements $UserSideJobEntityCopyWith<$Res> {
  factory _$$UserSideJobEntityImplCopyWith(
    _$UserSideJobEntityImpl value,
    $Res Function(_$UserSideJobEntityImpl) then,
  ) = __$$UserSideJobEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int sideJobId,
    String title,
    String description,
    String status,
    String startedAt,
    String? endedAt,
    String period,
  });
}

/// @nodoc
class __$$UserSideJobEntityImplCopyWithImpl<$Res>
    extends _$UserSideJobEntityCopyWithImpl<$Res, _$UserSideJobEntityImpl>
    implements _$$UserSideJobEntityImplCopyWith<$Res> {
  __$$UserSideJobEntityImplCopyWithImpl(
    _$UserSideJobEntityImpl _value,
    $Res Function(_$UserSideJobEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? period = null,
  }) {
    return _then(
      _$UserSideJobEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sideJobId: null == sideJobId
            ? _value.sideJobId
            : sideJobId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSideJobEntityImpl implements _UserSideJobEntity {
  const _$UserSideJobEntityImpl({
    required this.id,
    required this.sideJobId,
    required this.title,
    required this.description,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.period,
  });

  factory _$UserSideJobEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSideJobEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int sideJobId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String status;
  @override
  final String startedAt;
  @override
  final String? endedAt;
  @override
  final String period;

  @override
  String toString() {
    return 'UserSideJobEntity(id: $id, sideJobId: $sideJobId, title: $title, description: $description, status: $status, startedAt: $startedAt, endedAt: $endedAt, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSideJobEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sideJobId, sideJobId) ||
                other.sideJobId == sideJobId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sideJobId,
    title,
    description,
    status,
    startedAt,
    endedAt,
    period,
  );

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSideJobEntityImplCopyWith<_$UserSideJobEntityImpl> get copyWith =>
      __$$UserSideJobEntityImplCopyWithImpl<_$UserSideJobEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSideJobEntityImplToJson(this);
  }
}

abstract class _UserSideJobEntity implements UserSideJobEntity {
  const factory _UserSideJobEntity({
    required final int id,
    required final int sideJobId,
    required final String title,
    required final String description,
    required final String status,
    required final String startedAt,
    final String? endedAt,
    required final String period,
  }) = _$UserSideJobEntityImpl;

  factory _UserSideJobEntity.fromJson(Map<String, dynamic> json) =
      _$UserSideJobEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get sideJobId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get status;
  @override
  String get startedAt;
  @override
  String? get endedAt;
  @override
  String get period;

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSideJobEntityImplCopyWith<_$UserSideJobEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSideJobListEntity _$UserSideJobListEntityFromJson(
  Map<String, dynamic> json,
) {
  return _UserSideJobListEntity.fromJson(json);
}

/// @nodoc
mixin _$UserSideJobListEntity {
  List<UserSideJobEntity> get sideJobs => throw _privateConstructorUsedError;

  /// Serializes this UserSideJobListEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSideJobListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSideJobListEntityCopyWith<UserSideJobListEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSideJobListEntityCopyWith<$Res> {
  factory $UserSideJobListEntityCopyWith(
    UserSideJobListEntity value,
    $Res Function(UserSideJobListEntity) then,
  ) = _$UserSideJobListEntityCopyWithImpl<$Res, UserSideJobListEntity>;
  @useResult
  $Res call({List<UserSideJobEntity> sideJobs});
}

/// @nodoc
class _$UserSideJobListEntityCopyWithImpl<
  $Res,
  $Val extends UserSideJobListEntity
>
    implements $UserSideJobListEntityCopyWith<$Res> {
  _$UserSideJobListEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSideJobListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sideJobs = null}) {
    return _then(
      _value.copyWith(
            sideJobs: null == sideJobs
                ? _value.sideJobs
                : sideJobs // ignore: cast_nullable_to_non_nullable
                      as List<UserSideJobEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSideJobListEntityImplCopyWith<$Res>
    implements $UserSideJobListEntityCopyWith<$Res> {
  factory _$$UserSideJobListEntityImplCopyWith(
    _$UserSideJobListEntityImpl value,
    $Res Function(_$UserSideJobListEntityImpl) then,
  ) = __$$UserSideJobListEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserSideJobEntity> sideJobs});
}

/// @nodoc
class __$$UserSideJobListEntityImplCopyWithImpl<$Res>
    extends
        _$UserSideJobListEntityCopyWithImpl<$Res, _$UserSideJobListEntityImpl>
    implements _$$UserSideJobListEntityImplCopyWith<$Res> {
  __$$UserSideJobListEntityImplCopyWithImpl(
    _$UserSideJobListEntityImpl _value,
    $Res Function(_$UserSideJobListEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSideJobListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sideJobs = null}) {
    return _then(
      _$UserSideJobListEntityImpl(
        sideJobs: null == sideJobs
            ? _value._sideJobs
            : sideJobs // ignore: cast_nullable_to_non_nullable
                  as List<UserSideJobEntity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSideJobListEntityImpl implements _UserSideJobListEntity {
  const _$UserSideJobListEntityImpl({
    required final List<UserSideJobEntity> sideJobs,
  }) : _sideJobs = sideJobs;

  factory _$UserSideJobListEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSideJobListEntityImplFromJson(json);

  final List<UserSideJobEntity> _sideJobs;
  @override
  List<UserSideJobEntity> get sideJobs {
    if (_sideJobs is EqualUnmodifiableListView) return _sideJobs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sideJobs);
  }

  @override
  String toString() {
    return 'UserSideJobListEntity(sideJobs: $sideJobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSideJobListEntityImpl &&
            const DeepCollectionEquality().equals(other._sideJobs, _sideJobs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sideJobs));

  /// Create a copy of UserSideJobListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSideJobListEntityImplCopyWith<_$UserSideJobListEntityImpl>
  get copyWith =>
      __$$UserSideJobListEntityImplCopyWithImpl<_$UserSideJobListEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSideJobListEntityImplToJson(this);
  }
}

abstract class _UserSideJobListEntity implements UserSideJobListEntity {
  const factory _UserSideJobListEntity({
    required final List<UserSideJobEntity> sideJobs,
  }) = _$UserSideJobListEntityImpl;

  factory _UserSideJobListEntity.fromJson(Map<String, dynamic> json) =
      _$UserSideJobListEntityImpl.fromJson;

  @override
  List<UserSideJobEntity> get sideJobs;

  /// Create a copy of UserSideJobListEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSideJobListEntityImplCopyWith<_$UserSideJobListEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
