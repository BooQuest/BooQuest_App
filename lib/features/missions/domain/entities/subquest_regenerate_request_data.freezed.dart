// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subquest_regenerate_request_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubQuestRegenerateRequestData _$SubQuestRegenerateRequestDataFromJson(
  Map<String, dynamic> json,
) {
  return _SubQuestRegenerateRequestData.fromJson(json);
}

/// @nodoc
mixin _$SubQuestRegenerateRequestData {
  FeedbackData get feedbackData => throw _privateConstructorUsedError;
  GenerateMissionStep get generateMissionStep =>
      throw _privateConstructorUsedError;

  /// Serializes this SubQuestRegenerateRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubQuestRegenerateRequestDataCopyWith<SubQuestRegenerateRequestData>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubQuestRegenerateRequestDataCopyWith<$Res> {
  factory $SubQuestRegenerateRequestDataCopyWith(
    SubQuestRegenerateRequestData value,
    $Res Function(SubQuestRegenerateRequestData) then,
  ) =
      _$SubQuestRegenerateRequestDataCopyWithImpl<
        $Res,
        SubQuestRegenerateRequestData
      >;
  @useResult
  $Res call({
    FeedbackData feedbackData,
    GenerateMissionStep generateMissionStep,
  });

  $FeedbackDataCopyWith<$Res> get feedbackData;
  $GenerateMissionStepCopyWith<$Res> get generateMissionStep;
}

/// @nodoc
class _$SubQuestRegenerateRequestDataCopyWithImpl<
  $Res,
  $Val extends SubQuestRegenerateRequestData
>
    implements $SubQuestRegenerateRequestDataCopyWith<$Res> {
  _$SubQuestRegenerateRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? feedbackData = null, Object? generateMissionStep = null}) {
    return _then(
      _value.copyWith(
            feedbackData: null == feedbackData
                ? _value.feedbackData
                : feedbackData // ignore: cast_nullable_to_non_nullable
                      as FeedbackData,
            generateMissionStep: null == generateMissionStep
                ? _value.generateMissionStep
                : generateMissionStep // ignore: cast_nullable_to_non_nullable
                      as GenerateMissionStep,
          )
          as $Val,
    );
  }

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedbackDataCopyWith<$Res> get feedbackData {
    return $FeedbackDataCopyWith<$Res>(_value.feedbackData, (value) {
      return _then(_value.copyWith(feedbackData: value) as $Val);
    });
  }

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GenerateMissionStepCopyWith<$Res> get generateMissionStep {
    return $GenerateMissionStepCopyWith<$Res>(_value.generateMissionStep, (
      value,
    ) {
      return _then(_value.copyWith(generateMissionStep: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubQuestRegenerateRequestDataImplCopyWith<$Res>
    implements $SubQuestRegenerateRequestDataCopyWith<$Res> {
  factory _$$SubQuestRegenerateRequestDataImplCopyWith(
    _$SubQuestRegenerateRequestDataImpl value,
    $Res Function(_$SubQuestRegenerateRequestDataImpl) then,
  ) = __$$SubQuestRegenerateRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FeedbackData feedbackData,
    GenerateMissionStep generateMissionStep,
  });

  @override
  $FeedbackDataCopyWith<$Res> get feedbackData;
  @override
  $GenerateMissionStepCopyWith<$Res> get generateMissionStep;
}

/// @nodoc
class __$$SubQuestRegenerateRequestDataImplCopyWithImpl<$Res>
    extends
        _$SubQuestRegenerateRequestDataCopyWithImpl<
          $Res,
          _$SubQuestRegenerateRequestDataImpl
        >
    implements _$$SubQuestRegenerateRequestDataImplCopyWith<$Res> {
  __$$SubQuestRegenerateRequestDataImplCopyWithImpl(
    _$SubQuestRegenerateRequestDataImpl _value,
    $Res Function(_$SubQuestRegenerateRequestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? feedbackData = null, Object? generateMissionStep = null}) {
    return _then(
      _$SubQuestRegenerateRequestDataImpl(
        feedbackData: null == feedbackData
            ? _value.feedbackData
            : feedbackData // ignore: cast_nullable_to_non_nullable
                  as FeedbackData,
        generateMissionStep: null == generateMissionStep
            ? _value.generateMissionStep
            : generateMissionStep // ignore: cast_nullable_to_non_nullable
                  as GenerateMissionStep,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubQuestRegenerateRequestDataImpl
    implements _SubQuestRegenerateRequestData {
  const _$SubQuestRegenerateRequestDataImpl({
    required this.feedbackData,
    required this.generateMissionStep,
  });

  factory _$SubQuestRegenerateRequestDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SubQuestRegenerateRequestDataImplFromJson(json);

  @override
  final FeedbackData feedbackData;
  @override
  final GenerateMissionStep generateMissionStep;

  @override
  String toString() {
    return 'SubQuestRegenerateRequestData(feedbackData: $feedbackData, generateMissionStep: $generateMissionStep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubQuestRegenerateRequestDataImpl &&
            (identical(other.feedbackData, feedbackData) ||
                other.feedbackData == feedbackData) &&
            (identical(other.generateMissionStep, generateMissionStep) ||
                other.generateMissionStep == generateMissionStep));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, feedbackData, generateMissionStep);

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubQuestRegenerateRequestDataImplCopyWith<
    _$SubQuestRegenerateRequestDataImpl
  >
  get copyWith =>
      __$$SubQuestRegenerateRequestDataImplCopyWithImpl<
        _$SubQuestRegenerateRequestDataImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubQuestRegenerateRequestDataImplToJson(this);
  }
}

abstract class _SubQuestRegenerateRequestData
    implements SubQuestRegenerateRequestData {
  const factory _SubQuestRegenerateRequestData({
    required final FeedbackData feedbackData,
    required final GenerateMissionStep generateMissionStep,
  }) = _$SubQuestRegenerateRequestDataImpl;

  factory _SubQuestRegenerateRequestData.fromJson(Map<String, dynamic> json) =
      _$SubQuestRegenerateRequestDataImpl.fromJson;

  @override
  FeedbackData get feedbackData;
  @override
  GenerateMissionStep get generateMissionStep;

  /// Create a copy of SubQuestRegenerateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubQuestRegenerateRequestDataImplCopyWith<
    _$SubQuestRegenerateRequestDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

FeedbackData _$FeedbackDataFromJson(Map<String, dynamic> json) {
  return _FeedbackData.fromJson(json);
}

/// @nodoc
mixin _$FeedbackData {
  List<String> get reasons => throw _privateConstructorUsedError;
  String get etcFeedback => throw _privateConstructorUsedError;

  /// Serializes this FeedbackData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedbackData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedbackDataCopyWith<FeedbackData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackDataCopyWith<$Res> {
  factory $FeedbackDataCopyWith(
    FeedbackData value,
    $Res Function(FeedbackData) then,
  ) = _$FeedbackDataCopyWithImpl<$Res, FeedbackData>;
  @useResult
  $Res call({List<String> reasons, String etcFeedback});
}

/// @nodoc
class _$FeedbackDataCopyWithImpl<$Res, $Val extends FeedbackData>
    implements $FeedbackDataCopyWith<$Res> {
  _$FeedbackDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedbackData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reasons = null, Object? etcFeedback = null}) {
    return _then(
      _value.copyWith(
            reasons: null == reasons
                ? _value.reasons
                : reasons // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            etcFeedback: null == etcFeedback
                ? _value.etcFeedback
                : etcFeedback // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeedbackDataImplCopyWith<$Res>
    implements $FeedbackDataCopyWith<$Res> {
  factory _$$FeedbackDataImplCopyWith(
    _$FeedbackDataImpl value,
    $Res Function(_$FeedbackDataImpl) then,
  ) = __$$FeedbackDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> reasons, String etcFeedback});
}

/// @nodoc
class __$$FeedbackDataImplCopyWithImpl<$Res>
    extends _$FeedbackDataCopyWithImpl<$Res, _$FeedbackDataImpl>
    implements _$$FeedbackDataImplCopyWith<$Res> {
  __$$FeedbackDataImplCopyWithImpl(
    _$FeedbackDataImpl _value,
    $Res Function(_$FeedbackDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedbackData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reasons = null, Object? etcFeedback = null}) {
    return _then(
      _$FeedbackDataImpl(
        reasons: null == reasons
            ? _value._reasons
            : reasons // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        etcFeedback: null == etcFeedback
            ? _value.etcFeedback
            : etcFeedback // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackDataImpl implements _FeedbackData {
  const _$FeedbackDataImpl({
    required final List<String> reasons,
    required this.etcFeedback,
  }) : _reasons = reasons;

  factory _$FeedbackDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackDataImplFromJson(json);

  final List<String> _reasons;
  @override
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  @override
  final String etcFeedback;

  @override
  String toString() {
    return 'FeedbackData(reasons: $reasons, etcFeedback: $etcFeedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackDataImpl &&
            const DeepCollectionEquality().equals(other._reasons, _reasons) &&
            (identical(other.etcFeedback, etcFeedback) ||
                other.etcFeedback == etcFeedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_reasons),
    etcFeedback,
  );

  /// Create a copy of FeedbackData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackDataImplCopyWith<_$FeedbackDataImpl> get copyWith =>
      __$$FeedbackDataImplCopyWithImpl<_$FeedbackDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackDataImplToJson(this);
  }
}

abstract class _FeedbackData implements FeedbackData {
  const factory _FeedbackData({
    required final List<String> reasons,
    required final String etcFeedback,
  }) = _$FeedbackDataImpl;

  factory _FeedbackData.fromJson(Map<String, dynamic> json) =
      _$FeedbackDataImpl.fromJson;

  @override
  List<String> get reasons;
  @override
  String get etcFeedback;

  /// Create a copy of FeedbackData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedbackDataImplCopyWith<_$FeedbackDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GenerateMissionStep _$GenerateMissionStepFromJson(Map<String, dynamic> json) {
  return _GenerateMissionStep.fromJson(json);
}

/// @nodoc
mixin _$GenerateMissionStep {
  int get userId => throw _privateConstructorUsedError;
  int get missionId => throw _privateConstructorUsedError;
  String get missionTitle => throw _privateConstructorUsedError;
  String get missionDesignNotes => throw _privateConstructorUsedError;

  /// Serializes this GenerateMissionStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenerateMissionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenerateMissionStepCopyWith<GenerateMissionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateMissionStepCopyWith<$Res> {
  factory $GenerateMissionStepCopyWith(
    GenerateMissionStep value,
    $Res Function(GenerateMissionStep) then,
  ) = _$GenerateMissionStepCopyWithImpl<$Res, GenerateMissionStep>;
  @useResult
  $Res call({
    int userId,
    int missionId,
    String missionTitle,
    String missionDesignNotes,
  });
}

/// @nodoc
class _$GenerateMissionStepCopyWithImpl<$Res, $Val extends GenerateMissionStep>
    implements $GenerateMissionStepCopyWith<$Res> {
  _$GenerateMissionStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenerateMissionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? missionId = null,
    Object? missionTitle = null,
    Object? missionDesignNotes = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            missionId: null == missionId
                ? _value.missionId
                : missionId // ignore: cast_nullable_to_non_nullable
                      as int,
            missionTitle: null == missionTitle
                ? _value.missionTitle
                : missionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            missionDesignNotes: null == missionDesignNotes
                ? _value.missionDesignNotes
                : missionDesignNotes // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GenerateMissionStepImplCopyWith<$Res>
    implements $GenerateMissionStepCopyWith<$Res> {
  factory _$$GenerateMissionStepImplCopyWith(
    _$GenerateMissionStepImpl value,
    $Res Function(_$GenerateMissionStepImpl) then,
  ) = __$$GenerateMissionStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    int missionId,
    String missionTitle,
    String missionDesignNotes,
  });
}

/// @nodoc
class __$$GenerateMissionStepImplCopyWithImpl<$Res>
    extends _$GenerateMissionStepCopyWithImpl<$Res, _$GenerateMissionStepImpl>
    implements _$$GenerateMissionStepImplCopyWith<$Res> {
  __$$GenerateMissionStepImplCopyWithImpl(
    _$GenerateMissionStepImpl _value,
    $Res Function(_$GenerateMissionStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GenerateMissionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? missionId = null,
    Object? missionTitle = null,
    Object? missionDesignNotes = null,
  }) {
    return _then(
      _$GenerateMissionStepImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        missionId: null == missionId
            ? _value.missionId
            : missionId // ignore: cast_nullable_to_non_nullable
                  as int,
        missionTitle: null == missionTitle
            ? _value.missionTitle
            : missionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        missionDesignNotes: null == missionDesignNotes
            ? _value.missionDesignNotes
            : missionDesignNotes // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GenerateMissionStepImpl implements _GenerateMissionStep {
  const _$GenerateMissionStepImpl({
    required this.userId,
    required this.missionId,
    required this.missionTitle,
    required this.missionDesignNotes,
  });

  factory _$GenerateMissionStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenerateMissionStepImplFromJson(json);

  @override
  final int userId;
  @override
  final int missionId;
  @override
  final String missionTitle;
  @override
  final String missionDesignNotes;

  @override
  String toString() {
    return 'GenerateMissionStep(userId: $userId, missionId: $missionId, missionTitle: $missionTitle, missionDesignNotes: $missionDesignNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateMissionStepImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.missionTitle, missionTitle) ||
                other.missionTitle == missionTitle) &&
            (identical(other.missionDesignNotes, missionDesignNotes) ||
                other.missionDesignNotes == missionDesignNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    missionId,
    missionTitle,
    missionDesignNotes,
  );

  /// Create a copy of GenerateMissionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateMissionStepImplCopyWith<_$GenerateMissionStepImpl> get copyWith =>
      __$$GenerateMissionStepImplCopyWithImpl<_$GenerateMissionStepImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GenerateMissionStepImplToJson(this);
  }
}

abstract class _GenerateMissionStep implements GenerateMissionStep {
  const factory _GenerateMissionStep({
    required final int userId,
    required final int missionId,
    required final String missionTitle,
    required final String missionDesignNotes,
  }) = _$GenerateMissionStepImpl;

  factory _GenerateMissionStep.fromJson(Map<String, dynamic> json) =
      _$GenerateMissionStepImpl.fromJson;

  @override
  int get userId;
  @override
  int get missionId;
  @override
  String get missionTitle;
  @override
  String get missionDesignNotes;

  /// Create a copy of GenerateMissionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenerateMissionStepImplCopyWith<_$GenerateMissionStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
