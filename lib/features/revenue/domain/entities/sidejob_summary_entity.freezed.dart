// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidejob_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SideJobSummaryEntity _$SideJobSummaryEntityFromJson(Map<String, dynamic> json) {
  return _SideJobSummaryEntity.fromJson(json);
}

/// @nodoc
mixin _$SideJobSummaryEntity {
  UserSideJobEntity get userSideJob => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  int get totalIncome => throw _privateConstructorUsedError;
  int get completedQuestCount => throw _privateConstructorUsedError;
  int get daysToFirstIncome => throw _privateConstructorUsedError;

  /// Serializes this SideJobSummaryEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SideJobSummaryEntityCopyWith<SideJobSummaryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideJobSummaryEntityCopyWith<$Res> {
  factory $SideJobSummaryEntityCopyWith(
    SideJobSummaryEntity value,
    $Res Function(SideJobSummaryEntity) then,
  ) = _$SideJobSummaryEntityCopyWithImpl<$Res, SideJobSummaryEntity>;
  @useResult
  $Res call({
    UserSideJobEntity userSideJob,
    String period,
    int totalIncome,
    int completedQuestCount,
    int daysToFirstIncome,
  });

  $UserSideJobEntityCopyWith<$Res> get userSideJob;
}

/// @nodoc
class _$SideJobSummaryEntityCopyWithImpl<
  $Res,
  $Val extends SideJobSummaryEntity
>
    implements $SideJobSummaryEntityCopyWith<$Res> {
  _$SideJobSummaryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSideJob = null,
    Object? period = null,
    Object? totalIncome = null,
    Object? completedQuestCount = null,
    Object? daysToFirstIncome = null,
  }) {
    return _then(
      _value.copyWith(
            userSideJob: null == userSideJob
                ? _value.userSideJob
                : userSideJob // ignore: cast_nullable_to_non_nullable
                      as UserSideJobEntity,
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
            totalIncome: null == totalIncome
                ? _value.totalIncome
                : totalIncome // ignore: cast_nullable_to_non_nullable
                      as int,
            completedQuestCount: null == completedQuestCount
                ? _value.completedQuestCount
                : completedQuestCount // ignore: cast_nullable_to_non_nullable
                      as int,
            daysToFirstIncome: null == daysToFirstIncome
                ? _value.daysToFirstIncome
                : daysToFirstIncome // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSideJobEntityCopyWith<$Res> get userSideJob {
    return $UserSideJobEntityCopyWith<$Res>(_value.userSideJob, (value) {
      return _then(_value.copyWith(userSideJob: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SideJobSummaryEntityImplCopyWith<$Res>
    implements $SideJobSummaryEntityCopyWith<$Res> {
  factory _$$SideJobSummaryEntityImplCopyWith(
    _$SideJobSummaryEntityImpl value,
    $Res Function(_$SideJobSummaryEntityImpl) then,
  ) = __$$SideJobSummaryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserSideJobEntity userSideJob,
    String period,
    int totalIncome,
    int completedQuestCount,
    int daysToFirstIncome,
  });

  @override
  $UserSideJobEntityCopyWith<$Res> get userSideJob;
}

/// @nodoc
class __$$SideJobSummaryEntityImplCopyWithImpl<$Res>
    extends _$SideJobSummaryEntityCopyWithImpl<$Res, _$SideJobSummaryEntityImpl>
    implements _$$SideJobSummaryEntityImplCopyWith<$Res> {
  __$$SideJobSummaryEntityImplCopyWithImpl(
    _$SideJobSummaryEntityImpl _value,
    $Res Function(_$SideJobSummaryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSideJob = null,
    Object? period = null,
    Object? totalIncome = null,
    Object? completedQuestCount = null,
    Object? daysToFirstIncome = null,
  }) {
    return _then(
      _$SideJobSummaryEntityImpl(
        userSideJob: null == userSideJob
            ? _value.userSideJob
            : userSideJob // ignore: cast_nullable_to_non_nullable
                  as UserSideJobEntity,
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as int,
        completedQuestCount: null == completedQuestCount
            ? _value.completedQuestCount
            : completedQuestCount // ignore: cast_nullable_to_non_nullable
                  as int,
        daysToFirstIncome: null == daysToFirstIncome
            ? _value.daysToFirstIncome
            : daysToFirstIncome // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SideJobSummaryEntityImpl implements _SideJobSummaryEntity {
  const _$SideJobSummaryEntityImpl({
    required this.userSideJob,
    required this.period,
    required this.totalIncome,
    required this.completedQuestCount,
    required this.daysToFirstIncome,
  });

  factory _$SideJobSummaryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SideJobSummaryEntityImplFromJson(json);

  @override
  final UserSideJobEntity userSideJob;
  @override
  final String period;
  @override
  final int totalIncome;
  @override
  final int completedQuestCount;
  @override
  final int daysToFirstIncome;

  @override
  String toString() {
    return 'SideJobSummaryEntity(userSideJob: $userSideJob, period: $period, totalIncome: $totalIncome, completedQuestCount: $completedQuestCount, daysToFirstIncome: $daysToFirstIncome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SideJobSummaryEntityImpl &&
            (identical(other.userSideJob, userSideJob) ||
                other.userSideJob == userSideJob) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.completedQuestCount, completedQuestCount) ||
                other.completedQuestCount == completedQuestCount) &&
            (identical(other.daysToFirstIncome, daysToFirstIncome) ||
                other.daysToFirstIncome == daysToFirstIncome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userSideJob,
    period,
    totalIncome,
    completedQuestCount,
    daysToFirstIncome,
  );

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SideJobSummaryEntityImplCopyWith<_$SideJobSummaryEntityImpl>
  get copyWith =>
      __$$SideJobSummaryEntityImplCopyWithImpl<_$SideJobSummaryEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SideJobSummaryEntityImplToJson(this);
  }
}

abstract class _SideJobSummaryEntity implements SideJobSummaryEntity {
  const factory _SideJobSummaryEntity({
    required final UserSideJobEntity userSideJob,
    required final String period,
    required final int totalIncome,
    required final int completedQuestCount,
    required final int daysToFirstIncome,
  }) = _$SideJobSummaryEntityImpl;

  factory _SideJobSummaryEntity.fromJson(Map<String, dynamic> json) =
      _$SideJobSummaryEntityImpl.fromJson;

  @override
  UserSideJobEntity get userSideJob;
  @override
  String get period;
  @override
  int get totalIncome;
  @override
  int get completedQuestCount;
  @override
  int get daysToFirstIncome;

  /// Create a copy of SideJobSummaryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SideJobSummaryEntityImplCopyWith<_$SideJobSummaryEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UserSideJobEntity _$UserSideJobEntityFromJson(Map<String, dynamic> json) {
  return _UserSideJobEntity.fromJson(json);
}

/// @nodoc
mixin _$UserSideJobEntity {
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get sideJobId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get startedAt => throw _privateConstructorUsedError;
  String? get endedAt => throw _privateConstructorUsedError;
  List<MissionEntity> get missions => throw _privateConstructorUsedError;

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
    String createdAt,
    String updatedAt,
    int id,
    int userId,
    int sideJobId,
    String title,
    String description,
    String status,
    String startedAt,
    String? endedAt,
    List<MissionEntity> missions,
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
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? userId = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? missions = null,
  }) {
    return _then(
      _value.copyWith(
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
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
            missions: null == missions
                ? _value.missions
                : missions // ignore: cast_nullable_to_non_nullable
                      as List<MissionEntity>,
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
    String createdAt,
    String updatedAt,
    int id,
    int userId,
    int sideJobId,
    String title,
    String description,
    String status,
    String startedAt,
    String? endedAt,
    List<MissionEntity> missions,
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
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? userId = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? description = null,
    Object? status = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? missions = null,
  }) {
    return _then(
      _$UserSideJobEntityImpl(
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
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
        missions: null == missions
            ? _value._missions
            : missions // ignore: cast_nullable_to_non_nullable
                  as List<MissionEntity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSideJobEntityImpl implements _UserSideJobEntity {
  const _$UserSideJobEntityImpl({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.sideJobId,
    required this.title,
    required this.description,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required final List<MissionEntity> missions,
  }) : _missions = missions;

  factory _$UserSideJobEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSideJobEntityImplFromJson(json);

  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final int userId;
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
  final List<MissionEntity> _missions;
  @override
  List<MissionEntity> get missions {
    if (_missions is EqualUnmodifiableListView) return _missions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missions);
  }

  @override
  String toString() {
    return 'UserSideJobEntity(createdAt: $createdAt, updatedAt: $updatedAt, id: $id, userId: $userId, sideJobId: $sideJobId, title: $title, description: $description, status: $status, startedAt: $startedAt, endedAt: $endedAt, missions: $missions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSideJobEntityImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sideJobId, sideJobId) ||
                other.sideJobId == sideJobId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            const DeepCollectionEquality().equals(other._missions, _missions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    createdAt,
    updatedAt,
    id,
    userId,
    sideJobId,
    title,
    description,
    status,
    startedAt,
    endedAt,
    const DeepCollectionEquality().hash(_missions),
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
    required final String createdAt,
    required final String updatedAt,
    required final int id,
    required final int userId,
    required final int sideJobId,
    required final String title,
    required final String description,
    required final String status,
    required final String startedAt,
    final String? endedAt,
    required final List<MissionEntity> missions,
  }) = _$UserSideJobEntityImpl;

  factory _UserSideJobEntity.fromJson(Map<String, dynamic> json) =
      _$UserSideJobEntityImpl.fromJson;

  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  int get userId;
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
  List<MissionEntity> get missions;

  /// Create a copy of UserSideJobEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSideJobEntityImplCopyWith<_$UserSideJobEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) {
  return _MissionEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionEntity {
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get sideJobId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get orderNo => throw _privateConstructorUsedError;
  String get designNotes => throw _privateConstructorUsedError;
  List<StepEntity> get steps => throw _privateConstructorUsedError;

  /// Serializes this MissionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionEntityCopyWith<MissionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionEntityCopyWith<$Res> {
  factory $MissionEntityCopyWith(
    MissionEntity value,
    $Res Function(MissionEntity) then,
  ) = _$MissionEntityCopyWithImpl<$Res, MissionEntity>;
  @useResult
  $Res call({
    String createdAt,
    String updatedAt,
    int id,
    int sideJobId,
    int userId,
    String title,
    String status,
    int orderNo,
    String designNotes,
    List<StepEntity> steps,
  });
}

/// @nodoc
class _$MissionEntityCopyWithImpl<$Res, $Val extends MissionEntity>
    implements $MissionEntityCopyWith<$Res> {
  _$MissionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? sideJobId = null,
    Object? userId = null,
    Object? title = null,
    Object? status = null,
    Object? orderNo = null,
    Object? designNotes = null,
    Object? steps = null,
  }) {
    return _then(
      _value.copyWith(
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sideJobId: null == sideJobId
                ? _value.sideJobId
                : sideJobId // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            orderNo: null == orderNo
                ? _value.orderNo
                : orderNo // ignore: cast_nullable_to_non_nullable
                      as int,
            designNotes: null == designNotes
                ? _value.designNotes
                : designNotes // ignore: cast_nullable_to_non_nullable
                      as String,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<StepEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionEntityImplCopyWith<$Res>
    implements $MissionEntityCopyWith<$Res> {
  factory _$$MissionEntityImplCopyWith(
    _$MissionEntityImpl value,
    $Res Function(_$MissionEntityImpl) then,
  ) = __$$MissionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String createdAt,
    String updatedAt,
    int id,
    int sideJobId,
    int userId,
    String title,
    String status,
    int orderNo,
    String designNotes,
    List<StepEntity> steps,
  });
}

/// @nodoc
class __$$MissionEntityImplCopyWithImpl<$Res>
    extends _$MissionEntityCopyWithImpl<$Res, _$MissionEntityImpl>
    implements _$$MissionEntityImplCopyWith<$Res> {
  __$$MissionEntityImplCopyWithImpl(
    _$MissionEntityImpl _value,
    $Res Function(_$MissionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? sideJobId = null,
    Object? userId = null,
    Object? title = null,
    Object? status = null,
    Object? orderNo = null,
    Object? designNotes = null,
    Object? steps = null,
  }) {
    return _then(
      _$MissionEntityImpl(
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sideJobId: null == sideJobId
            ? _value.sideJobId
            : sideJobId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        orderNo: null == orderNo
            ? _value.orderNo
            : orderNo // ignore: cast_nullable_to_non_nullable
                  as int,
        designNotes: null == designNotes
            ? _value.designNotes
            : designNotes // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<StepEntity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionEntityImpl implements _MissionEntity {
  const _$MissionEntityImpl({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.sideJobId,
    required this.userId,
    required this.title,
    required this.status,
    required this.orderNo,
    required this.designNotes,
    required final List<StepEntity> steps,
  }) : _steps = steps;

  factory _$MissionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionEntityImplFromJson(json);

  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final int sideJobId;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String status;
  @override
  final int orderNo;
  @override
  final String designNotes;
  final List<StepEntity> _steps;
  @override
  List<StepEntity> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  String toString() {
    return 'MissionEntity(createdAt: $createdAt, updatedAt: $updatedAt, id: $id, sideJobId: $sideJobId, userId: $userId, title: $title, status: $status, orderNo: $orderNo, designNotes: $designNotes, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionEntityImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sideJobId, sideJobId) ||
                other.sideJobId == sideJobId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.designNotes, designNotes) ||
                other.designNotes == designNotes) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    createdAt,
    updatedAt,
    id,
    sideJobId,
    userId,
    title,
    status,
    orderNo,
    designNotes,
    const DeepCollectionEquality().hash(_steps),
  );

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionEntityImplCopyWith<_$MissionEntityImpl> get copyWith =>
      __$$MissionEntityImplCopyWithImpl<_$MissionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionEntityImplToJson(this);
  }
}

abstract class _MissionEntity implements MissionEntity {
  const factory _MissionEntity({
    required final String createdAt,
    required final String updatedAt,
    required final int id,
    required final int sideJobId,
    required final int userId,
    required final String title,
    required final String status,
    required final int orderNo,
    required final String designNotes,
    required final List<StepEntity> steps,
  }) = _$MissionEntityImpl;

  factory _MissionEntity.fromJson(Map<String, dynamic> json) =
      _$MissionEntityImpl.fromJson;

  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  int get sideJobId;
  @override
  int get userId;
  @override
  String get title;
  @override
  String get status;
  @override
  int get orderNo;
  @override
  String get designNotes;
  @override
  List<StepEntity> get steps;

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionEntityImplCopyWith<_$MissionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StepEntity _$StepEntityFromJson(Map<String, dynamic> json) {
  return _StepEntity.fromJson(json);
}

/// @nodoc
mixin _$StepEntity {
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get missionId => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this StepEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepEntityCopyWith<StepEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepEntityCopyWith<$Res> {
  factory $StepEntityCopyWith(
    StepEntity value,
    $Res Function(StepEntity) then,
  ) = _$StepEntityCopyWithImpl<$Res, StepEntity>;
  @useResult
  $Res call({
    String createdAt,
    String updatedAt,
    int id,
    int missionId,
    int seq,
    String title,
    String status,
    String detail,
    bool completed,
  });
}

/// @nodoc
class _$StepEntityCopyWithImpl<$Res, $Val extends StepEntity>
    implements $StepEntityCopyWith<$Res> {
  _$StepEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? missionId = null,
    Object? seq = null,
    Object? title = null,
    Object? status = null,
    Object? detail = null,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            missionId: null == missionId
                ? _value.missionId
                : missionId // ignore: cast_nullable_to_non_nullable
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
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StepEntityImplCopyWith<$Res>
    implements $StepEntityCopyWith<$Res> {
  factory _$$StepEntityImplCopyWith(
    _$StepEntityImpl value,
    $Res Function(_$StepEntityImpl) then,
  ) = __$$StepEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String createdAt,
    String updatedAt,
    int id,
    int missionId,
    int seq,
    String title,
    String status,
    String detail,
    bool completed,
  });
}

/// @nodoc
class __$$StepEntityImplCopyWithImpl<$Res>
    extends _$StepEntityCopyWithImpl<$Res, _$StepEntityImpl>
    implements _$$StepEntityImplCopyWith<$Res> {
  __$$StepEntityImplCopyWithImpl(
    _$StepEntityImpl _value,
    $Res Function(_$StepEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StepEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? missionId = null,
    Object? seq = null,
    Object? title = null,
    Object? status = null,
    Object? detail = null,
    Object? completed = null,
  }) {
    return _then(
      _$StepEntityImpl(
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        missionId: null == missionId
            ? _value.missionId
            : missionId // ignore: cast_nullable_to_non_nullable
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
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StepEntityImpl implements _StepEntity {
  const _$StepEntityImpl({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.missionId,
    required this.seq,
    required this.title,
    required this.status,
    required this.detail,
    required this.completed,
  });

  factory _$StepEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepEntityImplFromJson(json);

  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final int id;
  @override
  final int missionId;
  @override
  final int seq;
  @override
  final String title;
  @override
  final String status;
  @override
  final String detail;
  @override
  final bool completed;

  @override
  String toString() {
    return 'StepEntity(createdAt: $createdAt, updatedAt: $updatedAt, id: $id, missionId: $missionId, seq: $seq, title: $title, status: $status, detail: $detail, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepEntityImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    createdAt,
    updatedAt,
    id,
    missionId,
    seq,
    title,
    status,
    detail,
    completed,
  );

  /// Create a copy of StepEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepEntityImplCopyWith<_$StepEntityImpl> get copyWith =>
      __$$StepEntityImplCopyWithImpl<_$StepEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepEntityImplToJson(this);
  }
}

abstract class _StepEntity implements StepEntity {
  const factory _StepEntity({
    required final String createdAt,
    required final String updatedAt,
    required final int id,
    required final int missionId,
    required final int seq,
    required final String title,
    required final String status,
    required final String detail,
    required final bool completed,
  }) = _$StepEntityImpl;

  factory _StepEntity.fromJson(Map<String, dynamic> json) =
      _$StepEntityImpl.fromJson;

  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  int get id;
  @override
  int get missionId;
  @override
  int get seq;
  @override
  String get title;
  @override
  String get status;
  @override
  String get detail;
  @override
  bool get completed;

  /// Create a copy of StepEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepEntityImplCopyWith<_$StepEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
