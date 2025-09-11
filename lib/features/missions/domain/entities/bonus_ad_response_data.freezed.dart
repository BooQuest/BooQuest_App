// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bonus_ad_response_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BonusAdResponseData _$BonusAdResponseDataFromJson(Map<String, dynamic> json) {
  return _BonusAdResponseData.fromJson(json);
}

/// @nodoc
mixin _$BonusAdResponseData {
  bool get success => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  BonusAdData get data => throw _privateConstructorUsedError;

  /// Serializes this BonusAdResponseData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusAdResponseDataCopyWith<BonusAdResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusAdResponseDataCopyWith<$Res> {
  factory $BonusAdResponseDataCopyWith(
    BonusAdResponseData value,
    $Res Function(BonusAdResponseData) then,
  ) = _$BonusAdResponseDataCopyWithImpl<$Res, BonusAdResponseData>;
  @useResult
  $Res call({bool success, int status, String message, BonusAdData data});

  $BonusAdDataCopyWith<$Res> get data;
}

/// @nodoc
class _$BonusAdResponseDataCopyWithImpl<$Res, $Val extends BonusAdResponseData>
    implements $BonusAdResponseDataCopyWith<$Res> {
  _$BonusAdResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as BonusAdData,
          )
          as $Val,
    );
  }

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusAdDataCopyWith<$Res> get data {
    return $BonusAdDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BonusAdResponseDataImplCopyWith<$Res>
    implements $BonusAdResponseDataCopyWith<$Res> {
  factory _$$BonusAdResponseDataImplCopyWith(
    _$BonusAdResponseDataImpl value,
    $Res Function(_$BonusAdResponseDataImpl) then,
  ) = __$$BonusAdResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, int status, String message, BonusAdData data});

  @override
  $BonusAdDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$BonusAdResponseDataImplCopyWithImpl<$Res>
    extends _$BonusAdResponseDataCopyWithImpl<$Res, _$BonusAdResponseDataImpl>
    implements _$$BonusAdResponseDataImplCopyWith<$Res> {
  __$$BonusAdResponseDataImplCopyWithImpl(
    _$BonusAdResponseDataImpl _value,
    $Res Function(_$BonusAdResponseDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$BonusAdResponseDataImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as BonusAdData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BonusAdResponseDataImpl implements _BonusAdResponseData {
  const _$BonusAdResponseDataImpl({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory _$BonusAdResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusAdResponseDataImplFromJson(json);

  @override
  final bool success;
  @override
  final int status;
  @override
  final String message;
  @override
  final BonusAdData data;

  @override
  String toString() {
    return 'BonusAdResponseData(success: $success, status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusAdResponseDataImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, status, message, data);

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusAdResponseDataImplCopyWith<_$BonusAdResponseDataImpl> get copyWith =>
      __$$BonusAdResponseDataImplCopyWithImpl<_$BonusAdResponseDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusAdResponseDataImplToJson(this);
  }
}

abstract class _BonusAdResponseData implements BonusAdResponseData {
  const factory _BonusAdResponseData({
    required final bool success,
    required final int status,
    required final String message,
    required final BonusAdData data,
  }) = _$BonusAdResponseDataImpl;

  factory _BonusAdResponseData.fromJson(Map<String, dynamic> json) =
      _$BonusAdResponseDataImpl.fromJson;

  @override
  bool get success;
  @override
  int get status;
  @override
  String get message;
  @override
  BonusAdData get data;

  /// Create a copy of BonusAdResponseData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusAdResponseDataImplCopyWith<_$BonusAdResponseDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BonusAdData _$BonusAdDataFromJson(Map<String, dynamic> json) {
  return _BonusAdData.fromJson(json);
}

/// @nodoc
mixin _$BonusAdData {
  String get status => throw _privateConstructorUsedError;
  int get additionalExp => throw _privateConstructorUsedError;
  int get totalStepExp => throw _privateConstructorUsedError;
  bool get leveledUp => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;

  /// Serializes this BonusAdData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusAdData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusAdDataCopyWith<BonusAdData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusAdDataCopyWith<$Res> {
  factory $BonusAdDataCopyWith(
    BonusAdData value,
    $Res Function(BonusAdData) then,
  ) = _$BonusAdDataCopyWithImpl<$Res, BonusAdData>;
  @useResult
  $Res call({
    String status,
    int additionalExp,
    int totalStepExp,
    bool leveledUp,
    int currentLevel,
  });
}

/// @nodoc
class _$BonusAdDataCopyWithImpl<$Res, $Val extends BonusAdData>
    implements $BonusAdDataCopyWith<$Res> {
  _$BonusAdDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusAdData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? additionalExp = null,
    Object? totalStepExp = null,
    Object? leveledUp = null,
    Object? currentLevel = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            additionalExp: null == additionalExp
                ? _value.additionalExp
                : additionalExp // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStepExp: null == totalStepExp
                ? _value.totalStepExp
                : totalStepExp // ignore: cast_nullable_to_non_nullable
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
}

/// @nodoc
abstract class _$$BonusAdDataImplCopyWith<$Res>
    implements $BonusAdDataCopyWith<$Res> {
  factory _$$BonusAdDataImplCopyWith(
    _$BonusAdDataImpl value,
    $Res Function(_$BonusAdDataImpl) then,
  ) = __$$BonusAdDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    int additionalExp,
    int totalStepExp,
    bool leveledUp,
    int currentLevel,
  });
}

/// @nodoc
class __$$BonusAdDataImplCopyWithImpl<$Res>
    extends _$BonusAdDataCopyWithImpl<$Res, _$BonusAdDataImpl>
    implements _$$BonusAdDataImplCopyWith<$Res> {
  __$$BonusAdDataImplCopyWithImpl(
    _$BonusAdDataImpl _value,
    $Res Function(_$BonusAdDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonusAdData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? additionalExp = null,
    Object? totalStepExp = null,
    Object? leveledUp = null,
    Object? currentLevel = null,
  }) {
    return _then(
      _$BonusAdDataImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalExp: null == additionalExp
            ? _value.additionalExp
            : additionalExp // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStepExp: null == totalStepExp
            ? _value.totalStepExp
            : totalStepExp // ignore: cast_nullable_to_non_nullable
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
class _$BonusAdDataImpl implements _BonusAdData {
  const _$BonusAdDataImpl({
    required this.status,
    required this.additionalExp,
    required this.totalStepExp,
    required this.leveledUp,
    required this.currentLevel,
  });

  factory _$BonusAdDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusAdDataImplFromJson(json);

  @override
  final String status;
  @override
  final int additionalExp;
  @override
  final int totalStepExp;
  @override
  final bool leveledUp;
  @override
  final int currentLevel;

  @override
  String toString() {
    return 'BonusAdData(status: $status, additionalExp: $additionalExp, totalStepExp: $totalStepExp, leveledUp: $leveledUp, currentLevel: $currentLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusAdDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.additionalExp, additionalExp) ||
                other.additionalExp == additionalExp) &&
            (identical(other.totalStepExp, totalStepExp) ||
                other.totalStepExp == totalStepExp) &&
            (identical(other.leveledUp, leveledUp) ||
                other.leveledUp == leveledUp) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    additionalExp,
    totalStepExp,
    leveledUp,
    currentLevel,
  );

  /// Create a copy of BonusAdData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusAdDataImplCopyWith<_$BonusAdDataImpl> get copyWith =>
      __$$BonusAdDataImplCopyWithImpl<_$BonusAdDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusAdDataImplToJson(this);
  }
}

abstract class _BonusAdData implements BonusAdData {
  const factory _BonusAdData({
    required final String status,
    required final int additionalExp,
    required final int totalStepExp,
    required final bool leveledUp,
    required final int currentLevel,
  }) = _$BonusAdDataImpl;

  factory _BonusAdData.fromJson(Map<String, dynamic> json) =
      _$BonusAdDataImpl.fromJson;

  @override
  String get status;
  @override
  int get additionalExp;
  @override
  int get totalStepExp;
  @override
  bool get leveledUp;
  @override
  int get currentLevel;

  /// Create a copy of BonusAdData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusAdDataImplCopyWith<_$BonusAdDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
