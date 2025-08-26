// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) {
  return _MissionEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionEntity {
  int get id => throw _privateConstructorUsedError;
  int get sideJobId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get orderNo => throw _privateConstructorUsedError;
  String get designNotes => throw _privateConstructorUsedError;
  List<MissionStep> get steps => throw _privateConstructorUsedError;
  MissionProgress get progress => throw _privateConstructorUsedError;

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
    int id,
    int sideJobId,
    String title,
    String status,
    int? orderNo,
    String designNotes,
    List<MissionStep> steps,
    MissionProgress progress,
  });

  $MissionProgressCopyWith<$Res> get progress;
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
    Object? id = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? status = null,
    Object? orderNo = freezed,
    Object? designNotes = null,
    Object? steps = null,
    Object? progress = null,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            orderNo: freezed == orderNo
                ? _value.orderNo
                : orderNo // ignore: cast_nullable_to_non_nullable
                      as int?,
            designNotes: null == designNotes
                ? _value.designNotes
                : designNotes // ignore: cast_nullable_to_non_nullable
                      as String,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<MissionStep>,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as MissionProgress,
          )
          as $Val,
    );
  }

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissionProgressCopyWith<$Res> get progress {
    return $MissionProgressCopyWith<$Res>(_value.progress, (value) {
      return _then(_value.copyWith(progress: value) as $Val);
    });
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
    int id,
    int sideJobId,
    String title,
    String status,
    int? orderNo,
    String designNotes,
    List<MissionStep> steps,
    MissionProgress progress,
  });

  @override
  $MissionProgressCopyWith<$Res> get progress;
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
    Object? id = null,
    Object? sideJobId = null,
    Object? title = null,
    Object? status = null,
    Object? orderNo = freezed,
    Object? designNotes = null,
    Object? steps = null,
    Object? progress = null,
  }) {
    return _then(
      _$MissionEntityImpl(
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        orderNo: freezed == orderNo
            ? _value.orderNo
            : orderNo // ignore: cast_nullable_to_non_nullable
                  as int?,
        designNotes: null == designNotes
            ? _value.designNotes
            : designNotes // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<MissionStep>,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as MissionProgress,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionEntityImpl implements _MissionEntity {
  const _$MissionEntityImpl({
    required this.id,
    required this.sideJobId,
    required this.title,
    required this.status,
    this.orderNo,
    required this.designNotes,
    required final List<MissionStep> steps,
    required this.progress,
  }) : _steps = steps;

  factory _$MissionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int sideJobId;
  @override
  final String title;
  @override
  final String status;
  @override
  final int? orderNo;
  @override
  final String designNotes;
  final List<MissionStep> _steps;
  @override
  List<MissionStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final MissionProgress progress;

  @override
  String toString() {
    return 'MissionEntity(id: $id, sideJobId: $sideJobId, title: $title, status: $status, orderNo: $orderNo, designNotes: $designNotes, steps: $steps, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sideJobId, sideJobId) ||
                other.sideJobId == sideJobId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.designNotes, designNotes) ||
                other.designNotes == designNotes) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sideJobId,
    title,
    status,
    orderNo,
    designNotes,
    const DeepCollectionEquality().hash(_steps),
    progress,
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
    required final int id,
    required final int sideJobId,
    required final String title,
    required final String status,
    final int? orderNo,
    required final String designNotes,
    required final List<MissionStep> steps,
    required final MissionProgress progress,
  }) = _$MissionEntityImpl;

  factory _MissionEntity.fromJson(Map<String, dynamic> json) =
      _$MissionEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get sideJobId;
  @override
  String get title;
  @override
  String get status;
  @override
  int? get orderNo;
  @override
  String get designNotes;
  @override
  List<MissionStep> get steps;
  @override
  MissionProgress get progress;

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionEntityImplCopyWith<_$MissionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionStep _$MissionStepFromJson(Map<String, dynamic> json) {
  return _MissionStep.fromJson(json);
}

/// @nodoc
mixin _$MissionStep {
  int get id => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;

  /// Serializes this MissionStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionStepCopyWith<MissionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionStepCopyWith<$Res> {
  factory $MissionStepCopyWith(
    MissionStep value,
    $Res Function(MissionStep) then,
  ) = _$MissionStepCopyWithImpl<$Res, MissionStep>;
  @useResult
  $Res call({int id, int seq, String title, String status, String detail});
}

/// @nodoc
class _$MissionStepCopyWithImpl<$Res, $Val extends MissionStep>
    implements $MissionStepCopyWith<$Res> {
  _$MissionStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionStep
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
abstract class _$$MissionStepImplCopyWith<$Res>
    implements $MissionStepCopyWith<$Res> {
  factory _$$MissionStepImplCopyWith(
    _$MissionStepImpl value,
    $Res Function(_$MissionStepImpl) then,
  ) = __$$MissionStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int seq, String title, String status, String detail});
}

/// @nodoc
class __$$MissionStepImplCopyWithImpl<$Res>
    extends _$MissionStepCopyWithImpl<$Res, _$MissionStepImpl>
    implements _$$MissionStepImplCopyWith<$Res> {
  __$$MissionStepImplCopyWithImpl(
    _$MissionStepImpl _value,
    $Res Function(_$MissionStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionStep
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
      _$MissionStepImpl(
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
class _$MissionStepImpl implements _MissionStep {
  const _$MissionStepImpl({
    required this.id,
    required this.seq,
    required this.title,
    required this.status,
    required this.detail,
  });

  factory _$MissionStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionStepImplFromJson(json);

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
    return 'MissionStep(id: $id, seq: $seq, title: $title, status: $status, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, seq, title, status, detail);

  /// Create a copy of MissionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionStepImplCopyWith<_$MissionStepImpl> get copyWith =>
      __$$MissionStepImplCopyWithImpl<_$MissionStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionStepImplToJson(this);
  }
}

abstract class _MissionStep implements MissionStep {
  const factory _MissionStep({
    required final int id,
    required final int seq,
    required final String title,
    required final String status,
    required final String detail,
  }) = _$MissionStepImpl;

  factory _MissionStep.fromJson(Map<String, dynamic> json) =
      _$MissionStepImpl.fromJson;

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

  /// Create a copy of MissionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionStepImplCopyWith<_$MissionStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionProgress _$MissionProgressFromJson(Map<String, dynamic> json) {
  return _MissionProgress.fromJson(json);
}

/// @nodoc
mixin _$MissionProgress {
  int get percent => throw _privateConstructorUsedError;
  int get completedStepCount => throw _privateConstructorUsedError;
  int get totalStepCount => throw _privateConstructorUsedError;
  int? get currentStepId => throw _privateConstructorUsedError;
  int? get currentStepOrder => throw _privateConstructorUsedError;

  /// Serializes this MissionProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionProgressCopyWith<MissionProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionProgressCopyWith<$Res> {
  factory $MissionProgressCopyWith(
    MissionProgress value,
    $Res Function(MissionProgress) then,
  ) = _$MissionProgressCopyWithImpl<$Res, MissionProgress>;
  @useResult
  $Res call({
    int percent,
    int completedStepCount,
    int totalStepCount,
    int? currentStepId,
    int? currentStepOrder,
  });
}

/// @nodoc
class _$MissionProgressCopyWithImpl<$Res, $Val extends MissionProgress>
    implements $MissionProgressCopyWith<$Res> {
  _$MissionProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = null,
    Object? completedStepCount = null,
    Object? totalStepCount = null,
    Object? currentStepId = freezed,
    Object? currentStepOrder = freezed,
  }) {
    return _then(
      _value.copyWith(
            percent: null == percent
                ? _value.percent
                : percent // ignore: cast_nullable_to_non_nullable
                      as int,
            completedStepCount: null == completedStepCount
                ? _value.completedStepCount
                : completedStepCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStepCount: null == totalStepCount
                ? _value.totalStepCount
                : totalStepCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStepId: freezed == currentStepId
                ? _value.currentStepId
                : currentStepId // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentStepOrder: freezed == currentStepOrder
                ? _value.currentStepOrder
                : currentStepOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionProgressImplCopyWith<$Res>
    implements $MissionProgressCopyWith<$Res> {
  factory _$$MissionProgressImplCopyWith(
    _$MissionProgressImpl value,
    $Res Function(_$MissionProgressImpl) then,
  ) = __$$MissionProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int percent,
    int completedStepCount,
    int totalStepCount,
    int? currentStepId,
    int? currentStepOrder,
  });
}

/// @nodoc
class __$$MissionProgressImplCopyWithImpl<$Res>
    extends _$MissionProgressCopyWithImpl<$Res, _$MissionProgressImpl>
    implements _$$MissionProgressImplCopyWith<$Res> {
  __$$MissionProgressImplCopyWithImpl(
    _$MissionProgressImpl _value,
    $Res Function(_$MissionProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = null,
    Object? completedStepCount = null,
    Object? totalStepCount = null,
    Object? currentStepId = freezed,
    Object? currentStepOrder = freezed,
  }) {
    return _then(
      _$MissionProgressImpl(
        percent: null == percent
            ? _value.percent
            : percent // ignore: cast_nullable_to_non_nullable
                  as int,
        completedStepCount: null == completedStepCount
            ? _value.completedStepCount
            : completedStepCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStepCount: null == totalStepCount
            ? _value.totalStepCount
            : totalStepCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStepId: freezed == currentStepId
            ? _value.currentStepId
            : currentStepId // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentStepOrder: freezed == currentStepOrder
            ? _value.currentStepOrder
            : currentStepOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionProgressImpl implements _MissionProgress {
  const _$MissionProgressImpl({
    required this.percent,
    required this.completedStepCount,
    required this.totalStepCount,
    this.currentStepId,
    this.currentStepOrder,
  });

  factory _$MissionProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionProgressImplFromJson(json);

  @override
  final int percent;
  @override
  final int completedStepCount;
  @override
  final int totalStepCount;
  @override
  final int? currentStepId;
  @override
  final int? currentStepOrder;

  @override
  String toString() {
    return 'MissionProgress(percent: $percent, completedStepCount: $completedStepCount, totalStepCount: $totalStepCount, currentStepId: $currentStepId, currentStepOrder: $currentStepOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionProgressImpl &&
            (identical(other.percent, percent) || other.percent == percent) &&
            (identical(other.completedStepCount, completedStepCount) ||
                other.completedStepCount == completedStepCount) &&
            (identical(other.totalStepCount, totalStepCount) ||
                other.totalStepCount == totalStepCount) &&
            (identical(other.currentStepId, currentStepId) ||
                other.currentStepId == currentStepId) &&
            (identical(other.currentStepOrder, currentStepOrder) ||
                other.currentStepOrder == currentStepOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    percent,
    completedStepCount,
    totalStepCount,
    currentStepId,
    currentStepOrder,
  );

  /// Create a copy of MissionProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionProgressImplCopyWith<_$MissionProgressImpl> get copyWith =>
      __$$MissionProgressImplCopyWithImpl<_$MissionProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionProgressImplToJson(this);
  }
}

abstract class _MissionProgress implements MissionProgress {
  const factory _MissionProgress({
    required final int percent,
    required final int completedStepCount,
    required final int totalStepCount,
    final int? currentStepId,
    final int? currentStepOrder,
  }) = _$MissionProgressImpl;

  factory _MissionProgress.fromJson(Map<String, dynamic> json) =
      _$MissionProgressImpl.fromJson;

  @override
  int get percent;
  @override
  int get completedStepCount;
  @override
  int get totalStepCount;
  @override
  int? get currentStepId;
  @override
  int? get currentStepOrder;

  /// Create a copy of MissionProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionProgressImplCopyWith<_$MissionProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionListEntity _$MissionListEntityFromJson(Map<String, dynamic> json) {
  return _MissionListEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionListEntity {
  List<MissionEntity> get missions => throw _privateConstructorUsedError;

  /// Serializes this MissionListEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionListEntityCopyWith<MissionListEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionListEntityCopyWith<$Res> {
  factory $MissionListEntityCopyWith(
    MissionListEntity value,
    $Res Function(MissionListEntity) then,
  ) = _$MissionListEntityCopyWithImpl<$Res, MissionListEntity>;
  @useResult
  $Res call({List<MissionEntity> missions});
}

/// @nodoc
class _$MissionListEntityCopyWithImpl<$Res, $Val extends MissionListEntity>
    implements $MissionListEntityCopyWith<$Res> {
  _$MissionListEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? missions = null}) {
    return _then(
      _value.copyWith(
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
abstract class _$$MissionListEntityImplCopyWith<$Res>
    implements $MissionListEntityCopyWith<$Res> {
  factory _$$MissionListEntityImplCopyWith(
    _$MissionListEntityImpl value,
    $Res Function(_$MissionListEntityImpl) then,
  ) = __$$MissionListEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MissionEntity> missions});
}

/// @nodoc
class __$$MissionListEntityImplCopyWithImpl<$Res>
    extends _$MissionListEntityCopyWithImpl<$Res, _$MissionListEntityImpl>
    implements _$$MissionListEntityImplCopyWith<$Res> {
  __$$MissionListEntityImplCopyWithImpl(
    _$MissionListEntityImpl _value,
    $Res Function(_$MissionListEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionListEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? missions = null}) {
    return _then(
      _$MissionListEntityImpl(
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
class _$MissionListEntityImpl implements _MissionListEntity {
  const _$MissionListEntityImpl({required final List<MissionEntity> missions})
    : _missions = missions;

  factory _$MissionListEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionListEntityImplFromJson(json);

  final List<MissionEntity> _missions;
  @override
  List<MissionEntity> get missions {
    if (_missions is EqualUnmodifiableListView) return _missions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missions);
  }

  @override
  String toString() {
    return 'MissionListEntity(missions: $missions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionListEntityImpl &&
            const DeepCollectionEquality().equals(other._missions, _missions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_missions));

  /// Create a copy of MissionListEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionListEntityImplCopyWith<_$MissionListEntityImpl> get copyWith =>
      __$$MissionListEntityImplCopyWithImpl<_$MissionListEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionListEntityImplToJson(this);
  }
}

abstract class _MissionListEntity implements MissionListEntity {
  const factory _MissionListEntity({
    required final List<MissionEntity> missions,
  }) = _$MissionListEntityImpl;

  factory _MissionListEntity.fromJson(Map<String, dynamic> json) =
      _$MissionListEntityImpl.fromJson;

  @override
  List<MissionEntity> get missions;

  /// Create a copy of MissionListEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionListEntityImplCopyWith<_$MissionListEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
