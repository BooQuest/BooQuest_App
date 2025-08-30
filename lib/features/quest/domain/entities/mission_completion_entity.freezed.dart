// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_completion_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MissionCompletionEntity _$MissionCompletionEntityFromJson(
  Map<String, dynamic> json,
) {
  return _MissionCompletionEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionCompletionEntity {
  MissionEntity get mission => throw _privateConstructorUsedError;
  CharacterEntity get character => throw _privateConstructorUsedError;
  int get totalExpReward => throw _privateConstructorUsedError;
  int get stepExpReward => throw _privateConstructorUsedError;
  int get bonusExpReward => throw _privateConstructorUsedError;
  int get missionCompletionExpReward => throw _privateConstructorUsedError;
  int get levelUpCount => throw _privateConstructorUsedError;
  int get previousLevel => throw _privateConstructorUsedError;
  bool get missionCompleted => throw _privateConstructorUsedError;

  /// Serializes this MissionCompletionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionCompletionEntityCopyWith<MissionCompletionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCompletionEntityCopyWith<$Res> {
  factory $MissionCompletionEntityCopyWith(
    MissionCompletionEntity value,
    $Res Function(MissionCompletionEntity) then,
  ) = _$MissionCompletionEntityCopyWithImpl<$Res, MissionCompletionEntity>;
  @useResult
  $Res call({
    MissionEntity mission,
    CharacterEntity character,
    int totalExpReward,
    int stepExpReward,
    int bonusExpReward,
    int missionCompletionExpReward,
    int levelUpCount,
    int previousLevel,
    bool missionCompleted,
  });

  $MissionEntityCopyWith<$Res> get mission;
  $CharacterEntityCopyWith<$Res> get character;
}

/// @nodoc
class _$MissionCompletionEntityCopyWithImpl<
  $Res,
  $Val extends MissionCompletionEntity
>
    implements $MissionCompletionEntityCopyWith<$Res> {
  _$MissionCompletionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mission = null,
    Object? character = null,
    Object? totalExpReward = null,
    Object? stepExpReward = null,
    Object? bonusExpReward = null,
    Object? missionCompletionExpReward = null,
    Object? levelUpCount = null,
    Object? previousLevel = null,
    Object? missionCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            mission: null == mission
                ? _value.mission
                : mission // ignore: cast_nullable_to_non_nullable
                      as MissionEntity,
            character: null == character
                ? _value.character
                : character // ignore: cast_nullable_to_non_nullable
                      as CharacterEntity,
            totalExpReward: null == totalExpReward
                ? _value.totalExpReward
                : totalExpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            stepExpReward: null == stepExpReward
                ? _value.stepExpReward
                : stepExpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            bonusExpReward: null == bonusExpReward
                ? _value.bonusExpReward
                : bonusExpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            missionCompletionExpReward: null == missionCompletionExpReward
                ? _value.missionCompletionExpReward
                : missionCompletionExpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            levelUpCount: null == levelUpCount
                ? _value.levelUpCount
                : levelUpCount // ignore: cast_nullable_to_non_nullable
                      as int,
            previousLevel: null == previousLevel
                ? _value.previousLevel
                : previousLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            missionCompleted: null == missionCompleted
                ? _value.missionCompleted
                : missionCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissionEntityCopyWith<$Res> get mission {
    return $MissionEntityCopyWith<$Res>(_value.mission, (value) {
      return _then(_value.copyWith(mission: value) as $Val);
    });
  }

  /// Create a copy of MissionCompletionEntity
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
abstract class _$$MissionCompletionEntityImplCopyWith<$Res>
    implements $MissionCompletionEntityCopyWith<$Res> {
  factory _$$MissionCompletionEntityImplCopyWith(
    _$MissionCompletionEntityImpl value,
    $Res Function(_$MissionCompletionEntityImpl) then,
  ) = __$$MissionCompletionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MissionEntity mission,
    CharacterEntity character,
    int totalExpReward,
    int stepExpReward,
    int bonusExpReward,
    int missionCompletionExpReward,
    int levelUpCount,
    int previousLevel,
    bool missionCompleted,
  });

  @override
  $MissionEntityCopyWith<$Res> get mission;
  @override
  $CharacterEntityCopyWith<$Res> get character;
}

/// @nodoc
class __$$MissionCompletionEntityImplCopyWithImpl<$Res>
    extends
        _$MissionCompletionEntityCopyWithImpl<
          $Res,
          _$MissionCompletionEntityImpl
        >
    implements _$$MissionCompletionEntityImplCopyWith<$Res> {
  __$$MissionCompletionEntityImplCopyWithImpl(
    _$MissionCompletionEntityImpl _value,
    $Res Function(_$MissionCompletionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mission = null,
    Object? character = null,
    Object? totalExpReward = null,
    Object? stepExpReward = null,
    Object? bonusExpReward = null,
    Object? missionCompletionExpReward = null,
    Object? levelUpCount = null,
    Object? previousLevel = null,
    Object? missionCompleted = null,
  }) {
    return _then(
      _$MissionCompletionEntityImpl(
        mission: null == mission
            ? _value.mission
            : mission // ignore: cast_nullable_to_non_nullable
                  as MissionEntity,
        character: null == character
            ? _value.character
            : character // ignore: cast_nullable_to_non_nullable
                  as CharacterEntity,
        totalExpReward: null == totalExpReward
            ? _value.totalExpReward
            : totalExpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        stepExpReward: null == stepExpReward
            ? _value.stepExpReward
            : stepExpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        bonusExpReward: null == bonusExpReward
            ? _value.bonusExpReward
            : bonusExpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        missionCompletionExpReward: null == missionCompletionExpReward
            ? _value.missionCompletionExpReward
            : missionCompletionExpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        levelUpCount: null == levelUpCount
            ? _value.levelUpCount
            : levelUpCount // ignore: cast_nullable_to_non_nullable
                  as int,
        previousLevel: null == previousLevel
            ? _value.previousLevel
            : previousLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        missionCompleted: null == missionCompleted
            ? _value.missionCompleted
            : missionCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionCompletionEntityImpl implements _MissionCompletionEntity {
  const _$MissionCompletionEntityImpl({
    required this.mission,
    required this.character,
    required this.totalExpReward,
    required this.stepExpReward,
    required this.bonusExpReward,
    required this.missionCompletionExpReward,
    required this.levelUpCount,
    required this.previousLevel,
    required this.missionCompleted,
  });

  factory _$MissionCompletionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionCompletionEntityImplFromJson(json);

  @override
  final MissionEntity mission;
  @override
  final CharacterEntity character;
  @override
  final int totalExpReward;
  @override
  final int stepExpReward;
  @override
  final int bonusExpReward;
  @override
  final int missionCompletionExpReward;
  @override
  final int levelUpCount;
  @override
  final int previousLevel;
  @override
  final bool missionCompleted;

  @override
  String toString() {
    return 'MissionCompletionEntity(mission: $mission, character: $character, totalExpReward: $totalExpReward, stepExpReward: $stepExpReward, bonusExpReward: $bonusExpReward, missionCompletionExpReward: $missionCompletionExpReward, levelUpCount: $levelUpCount, previousLevel: $previousLevel, missionCompleted: $missionCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionCompletionEntityImpl &&
            (identical(other.mission, mission) || other.mission == mission) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.totalExpReward, totalExpReward) ||
                other.totalExpReward == totalExpReward) &&
            (identical(other.stepExpReward, stepExpReward) ||
                other.stepExpReward == stepExpReward) &&
            (identical(other.bonusExpReward, bonusExpReward) ||
                other.bonusExpReward == bonusExpReward) &&
            (identical(
                  other.missionCompletionExpReward,
                  missionCompletionExpReward,
                ) ||
                other.missionCompletionExpReward ==
                    missionCompletionExpReward) &&
            (identical(other.levelUpCount, levelUpCount) ||
                other.levelUpCount == levelUpCount) &&
            (identical(other.previousLevel, previousLevel) ||
                other.previousLevel == previousLevel) &&
            (identical(other.missionCompleted, missionCompleted) ||
                other.missionCompleted == missionCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mission,
    character,
    totalExpReward,
    stepExpReward,
    bonusExpReward,
    missionCompletionExpReward,
    levelUpCount,
    previousLevel,
    missionCompleted,
  );

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionCompletionEntityImplCopyWith<_$MissionCompletionEntityImpl>
  get copyWith =>
      __$$MissionCompletionEntityImplCopyWithImpl<
        _$MissionCompletionEntityImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionCompletionEntityImplToJson(this);
  }
}

abstract class _MissionCompletionEntity implements MissionCompletionEntity {
  const factory _MissionCompletionEntity({
    required final MissionEntity mission,
    required final CharacterEntity character,
    required final int totalExpReward,
    required final int stepExpReward,
    required final int bonusExpReward,
    required final int missionCompletionExpReward,
    required final int levelUpCount,
    required final int previousLevel,
    required final bool missionCompleted,
  }) = _$MissionCompletionEntityImpl;

  factory _MissionCompletionEntity.fromJson(Map<String, dynamic> json) =
      _$MissionCompletionEntityImpl.fromJson;

  @override
  MissionEntity get mission;
  @override
  CharacterEntity get character;
  @override
  int get totalExpReward;
  @override
  int get stepExpReward;
  @override
  int get bonusExpReward;
  @override
  int get missionCompletionExpReward;
  @override
  int get levelUpCount;
  @override
  int get previousLevel;
  @override
  bool get missionCompleted;

  /// Create a copy of MissionCompletionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionCompletionEntityImplCopyWith<_$MissionCompletionEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) {
  return _MissionEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionEntity {
  int get id => throw _privateConstructorUsedError;
  int get sideJobId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get orderNo => throw _privateConstructorUsedError;
  String get designNotes => throw _privateConstructorUsedError;
  String get guide => throw _privateConstructorUsedError;
  int get missionTotalExp => throw _privateConstructorUsedError;
  List<MissionStepEntity> get steps => throw _privateConstructorUsedError;
  MissionProgressEntity get progress => throw _privateConstructorUsedError;

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
    int orderNo,
    String designNotes,
    String guide,
    int missionTotalExp,
    List<MissionStepEntity> steps,
    MissionProgressEntity progress,
  });

  $MissionProgressEntityCopyWith<$Res> get progress;
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
    Object? orderNo = null,
    Object? designNotes = null,
    Object? guide = null,
    Object? missionTotalExp = null,
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
            orderNo: null == orderNo
                ? _value.orderNo
                : orderNo // ignore: cast_nullable_to_non_nullable
                      as int,
            designNotes: null == designNotes
                ? _value.designNotes
                : designNotes // ignore: cast_nullable_to_non_nullable
                      as String,
            guide: null == guide
                ? _value.guide
                : guide // ignore: cast_nullable_to_non_nullable
                      as String,
            missionTotalExp: null == missionTotalExp
                ? _value.missionTotalExp
                : missionTotalExp // ignore: cast_nullable_to_non_nullable
                      as int,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<MissionStepEntity>,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as MissionProgressEntity,
          )
          as $Val,
    );
  }

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissionProgressEntityCopyWith<$Res> get progress {
    return $MissionProgressEntityCopyWith<$Res>(_value.progress, (value) {
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
    int orderNo,
    String designNotes,
    String guide,
    int missionTotalExp,
    List<MissionStepEntity> steps,
    MissionProgressEntity progress,
  });

  @override
  $MissionProgressEntityCopyWith<$Res> get progress;
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
    Object? orderNo = null,
    Object? designNotes = null,
    Object? guide = null,
    Object? missionTotalExp = null,
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
        orderNo: null == orderNo
            ? _value.orderNo
            : orderNo // ignore: cast_nullable_to_non_nullable
                  as int,
        designNotes: null == designNotes
            ? _value.designNotes
            : designNotes // ignore: cast_nullable_to_non_nullable
                  as String,
        guide: null == guide
            ? _value.guide
            : guide // ignore: cast_nullable_to_non_nullable
                  as String,
        missionTotalExp: null == missionTotalExp
            ? _value.missionTotalExp
            : missionTotalExp // ignore: cast_nullable_to_non_nullable
                  as int,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<MissionStepEntity>,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as MissionProgressEntity,
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
    required this.orderNo,
    required this.designNotes,
    required this.guide,
    required this.missionTotalExp,
    required final List<MissionStepEntity> steps,
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
  final int orderNo;
  @override
  final String designNotes;
  @override
  final String guide;
  @override
  final int missionTotalExp;
  final List<MissionStepEntity> _steps;
  @override
  List<MissionStepEntity> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final MissionProgressEntity progress;

  @override
  String toString() {
    return 'MissionEntity(id: $id, sideJobId: $sideJobId, title: $title, status: $status, orderNo: $orderNo, designNotes: $designNotes, guide: $guide, missionTotalExp: $missionTotalExp, steps: $steps, progress: $progress)';
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
            (identical(other.guide, guide) || other.guide == guide) &&
            (identical(other.missionTotalExp, missionTotalExp) ||
                other.missionTotalExp == missionTotalExp) &&
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
    guide,
    missionTotalExp,
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
    required final int orderNo,
    required final String designNotes,
    required final String guide,
    required final int missionTotalExp,
    required final List<MissionStepEntity> steps,
    required final MissionProgressEntity progress,
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
  int get orderNo;
  @override
  String get designNotes;
  @override
  String get guide;
  @override
  int get missionTotalExp;
  @override
  List<MissionStepEntity> get steps;
  @override
  MissionProgressEntity get progress;

  /// Create a copy of MissionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionEntityImplCopyWith<_$MissionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

MissionProgressEntity _$MissionProgressEntityFromJson(
  Map<String, dynamic> json,
) {
  return _MissionProgressEntity.fromJson(json);
}

/// @nodoc
mixin _$MissionProgressEntity {
  int get percent => throw _privateConstructorUsedError;
  int get completedStepCount => throw _privateConstructorUsedError;
  int get totalStepCount => throw _privateConstructorUsedError;
  int? get currentStepId => throw _privateConstructorUsedError; // null일 수 있음
  int? get currentStepOrder => throw _privateConstructorUsedError;

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
    int percent,
    int completedStepCount,
    int totalStepCount,
    int? currentStepId,
    int? currentStepOrder,
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
abstract class _$$MissionProgressEntityImplCopyWith<$Res>
    implements $MissionProgressEntityCopyWith<$Res> {
  factory _$$MissionProgressEntityImplCopyWith(
    _$MissionProgressEntityImpl value,
    $Res Function(_$MissionProgressEntityImpl) then,
  ) = __$$MissionProgressEntityImplCopyWithImpl<$Res>;
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
    Object? percent = null,
    Object? completedStepCount = null,
    Object? totalStepCount = null,
    Object? currentStepId = freezed,
    Object? currentStepOrder = freezed,
  }) {
    return _then(
      _$MissionProgressEntityImpl(
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
class _$MissionProgressEntityImpl implements _MissionProgressEntity {
  const _$MissionProgressEntityImpl({
    required this.percent,
    required this.completedStepCount,
    required this.totalStepCount,
    required this.currentStepId,
    required this.currentStepOrder,
  });

  factory _$MissionProgressEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionProgressEntityImplFromJson(json);

  @override
  final int percent;
  @override
  final int completedStepCount;
  @override
  final int totalStepCount;
  @override
  final int? currentStepId;
  // null일 수 있음
  @override
  final int? currentStepOrder;

  @override
  String toString() {
    return 'MissionProgressEntity(percent: $percent, completedStepCount: $completedStepCount, totalStepCount: $totalStepCount, currentStepId: $currentStepId, currentStepOrder: $currentStepOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionProgressEntityImpl &&
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
    required final int percent,
    required final int completedStepCount,
    required final int totalStepCount,
    required final int? currentStepId,
    required final int? currentStepOrder,
  }) = _$MissionProgressEntityImpl;

  factory _MissionProgressEntity.fromJson(Map<String, dynamic> json) =
      _$MissionProgressEntityImpl.fromJson;

  @override
  int get percent;
  @override
  int get completedStepCount;
  @override
  int get totalStepCount;
  @override
  int? get currentStepId; // null일 수 있음
  @override
  int? get currentStepOrder;

  /// Create a copy of MissionProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionProgressEntityImplCopyWith<_$MissionProgressEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
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
  String? get avatarUrl => throw _privateConstructorUsedError;

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
    String? avatarUrl,
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
    Object? avatarUrl = freezed,
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
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String? avatarUrl,
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
    Object? avatarUrl = freezed,
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
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
  final String? avatarUrl;

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
    required final String? avatarUrl,
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
  String? get avatarUrl;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterEntityImplCopyWith<_$CharacterEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
