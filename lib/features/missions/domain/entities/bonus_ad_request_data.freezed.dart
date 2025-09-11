// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bonus_ad_request_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BonusAdRequestData _$BonusAdRequestDataFromJson(Map<String, dynamic> json) {
  return _BonusAdRequestData.fromJson(json);
}

/// @nodoc
mixin _$BonusAdRequestData {
  String get receipt => throw _privateConstructorUsedError;
  String get adSessionId => throw _privateConstructorUsedError;

  /// Serializes this BonusAdRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusAdRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusAdRequestDataCopyWith<BonusAdRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusAdRequestDataCopyWith<$Res> {
  factory $BonusAdRequestDataCopyWith(
    BonusAdRequestData value,
    $Res Function(BonusAdRequestData) then,
  ) = _$BonusAdRequestDataCopyWithImpl<$Res, BonusAdRequestData>;
  @useResult
  $Res call({String receipt, String adSessionId});
}

/// @nodoc
class _$BonusAdRequestDataCopyWithImpl<$Res, $Val extends BonusAdRequestData>
    implements $BonusAdRequestDataCopyWith<$Res> {
  _$BonusAdRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusAdRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receipt = null, Object? adSessionId = null}) {
    return _then(
      _value.copyWith(
            receipt: null == receipt
                ? _value.receipt
                : receipt // ignore: cast_nullable_to_non_nullable
                      as String,
            adSessionId: null == adSessionId
                ? _value.adSessionId
                : adSessionId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BonusAdRequestDataImplCopyWith<$Res>
    implements $BonusAdRequestDataCopyWith<$Res> {
  factory _$$BonusAdRequestDataImplCopyWith(
    _$BonusAdRequestDataImpl value,
    $Res Function(_$BonusAdRequestDataImpl) then,
  ) = __$$BonusAdRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receipt, String adSessionId});
}

/// @nodoc
class __$$BonusAdRequestDataImplCopyWithImpl<$Res>
    extends _$BonusAdRequestDataCopyWithImpl<$Res, _$BonusAdRequestDataImpl>
    implements _$$BonusAdRequestDataImplCopyWith<$Res> {
  __$$BonusAdRequestDataImplCopyWithImpl(
    _$BonusAdRequestDataImpl _value,
    $Res Function(_$BonusAdRequestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonusAdRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receipt = null, Object? adSessionId = null}) {
    return _then(
      _$BonusAdRequestDataImpl(
        receipt: null == receipt
            ? _value.receipt
            : receipt // ignore: cast_nullable_to_non_nullable
                  as String,
        adSessionId: null == adSessionId
            ? _value.adSessionId
            : adSessionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BonusAdRequestDataImpl implements _BonusAdRequestData {
  const _$BonusAdRequestDataImpl({
    required this.receipt,
    required this.adSessionId,
  });

  factory _$BonusAdRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusAdRequestDataImplFromJson(json);

  @override
  final String receipt;
  @override
  final String adSessionId;

  @override
  String toString() {
    return 'BonusAdRequestData(receipt: $receipt, adSessionId: $adSessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusAdRequestDataImpl &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.adSessionId, adSessionId) ||
                other.adSessionId == adSessionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, receipt, adSessionId);

  /// Create a copy of BonusAdRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusAdRequestDataImplCopyWith<_$BonusAdRequestDataImpl> get copyWith =>
      __$$BonusAdRequestDataImplCopyWithImpl<_$BonusAdRequestDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusAdRequestDataImplToJson(this);
  }
}

abstract class _BonusAdRequestData implements BonusAdRequestData {
  const factory _BonusAdRequestData({
    required final String receipt,
    required final String adSessionId,
  }) = _$BonusAdRequestDataImpl;

  factory _BonusAdRequestData.fromJson(Map<String, dynamic> json) =
      _$BonusAdRequestDataImpl.fromJson;

  @override
  String get receipt;
  @override
  String get adSessionId;

  /// Create a copy of BonusAdRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusAdRequestDataImplCopyWith<_$BonusAdRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
