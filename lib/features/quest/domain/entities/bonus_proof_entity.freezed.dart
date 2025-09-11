// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bonus_proof_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BonusProofEntity _$BonusProofEntityFromJson(Map<String, dynamic> json) {
  return _BonusProofEntity.fromJson(json);
}

/// @nodoc
mixin _$BonusProofEntity {
  String get status => throw _privateConstructorUsedError;
  int get additionalExp => throw _privateConstructorUsedError;
  bool get leveledUp => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;

  /// Serializes this BonusProofEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusProofEntityCopyWith<BonusProofEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusProofEntityCopyWith<$Res> {
  factory $BonusProofEntityCopyWith(
    BonusProofEntity value,
    $Res Function(BonusProofEntity) then,
  ) = _$BonusProofEntityCopyWithImpl<$Res, BonusProofEntity>;
  @useResult
  $Res call({
    String status,
    int additionalExp,
    bool leveledUp,
    int currentLevel,
  });
}

/// @nodoc
class _$BonusProofEntityCopyWithImpl<$Res, $Val extends BonusProofEntity>
    implements $BonusProofEntityCopyWith<$Res> {
  _$BonusProofEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? additionalExp = null,
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
abstract class _$$BonusProofEntityImplCopyWith<$Res>
    implements $BonusProofEntityCopyWith<$Res> {
  factory _$$BonusProofEntityImplCopyWith(
    _$BonusProofEntityImpl value,
    $Res Function(_$BonusProofEntityImpl) then,
  ) = __$$BonusProofEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    int additionalExp,
    bool leveledUp,
    int currentLevel,
  });
}

/// @nodoc
class __$$BonusProofEntityImplCopyWithImpl<$Res>
    extends _$BonusProofEntityCopyWithImpl<$Res, _$BonusProofEntityImpl>
    implements _$$BonusProofEntityImplCopyWith<$Res> {
  __$$BonusProofEntityImplCopyWithImpl(
    _$BonusProofEntityImpl _value,
    $Res Function(_$BonusProofEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonusProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? additionalExp = null,
    Object? leveledUp = null,
    Object? currentLevel = null,
  }) {
    return _then(
      _$BonusProofEntityImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalExp: null == additionalExp
            ? _value.additionalExp
            : additionalExp // ignore: cast_nullable_to_non_nullable
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
class _$BonusProofEntityImpl implements _BonusProofEntity {
  const _$BonusProofEntityImpl({
    required this.status,
    required this.additionalExp,
    this.leveledUp = false,
    this.currentLevel = 0,
  });

  factory _$BonusProofEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusProofEntityImplFromJson(json);

  @override
  final String status;
  @override
  final int additionalExp;
  @override
  @JsonKey()
  final bool leveledUp;
  @override
  @JsonKey()
  final int currentLevel;

  @override
  String toString() {
    return 'BonusProofEntity(status: $status, additionalExp: $additionalExp, leveledUp: $leveledUp, currentLevel: $currentLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusProofEntityImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.additionalExp, additionalExp) ||
                other.additionalExp == additionalExp) &&
            (identical(other.leveledUp, leveledUp) ||
                other.leveledUp == leveledUp) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, additionalExp, leveledUp, currentLevel);

  /// Create a copy of BonusProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusProofEntityImplCopyWith<_$BonusProofEntityImpl> get copyWith =>
      __$$BonusProofEntityImplCopyWithImpl<_$BonusProofEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusProofEntityImplToJson(this);
  }
}

abstract class _BonusProofEntity implements BonusProofEntity {
  const factory _BonusProofEntity({
    required final String status,
    required final int additionalExp,
    final bool leveledUp,
    final int currentLevel,
  }) = _$BonusProofEntityImpl;

  factory _BonusProofEntity.fromJson(Map<String, dynamic> json) =
      _$BonusProofEntityImpl.fromJson;

  @override
  String get status;
  @override
  int get additionalExp;
  @override
  bool get leveledUp;
  @override
  int get currentLevel;

  /// Create a copy of BonusProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusProofEntityImplCopyWith<_$BonusProofEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BonusProofRequest _$BonusProofRequestFromJson(Map<String, dynamic> json) {
  return _BonusProofRequest.fromJson(json);
}

/// @nodoc
mixin _$BonusProofRequest {
  ProofType get proofType => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this BonusProofRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusProofRequestCopyWith<BonusProofRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusProofRequestCopyWith<$Res> {
  factory $BonusProofRequestCopyWith(
    BonusProofRequest value,
    $Res Function(BonusProofRequest) then,
  ) = _$BonusProofRequestCopyWithImpl<$Res, BonusProofRequest>;
  @useResult
  $Res call({ProofType proofType, String content});
}

/// @nodoc
class _$BonusProofRequestCopyWithImpl<$Res, $Val extends BonusProofRequest>
    implements $BonusProofRequestCopyWith<$Res> {
  _$BonusProofRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? proofType = null, Object? content = null}) {
    return _then(
      _value.copyWith(
            proofType: null == proofType
                ? _value.proofType
                : proofType // ignore: cast_nullable_to_non_nullable
                      as ProofType,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BonusProofRequestImplCopyWith<$Res>
    implements $BonusProofRequestCopyWith<$Res> {
  factory _$$BonusProofRequestImplCopyWith(
    _$BonusProofRequestImpl value,
    $Res Function(_$BonusProofRequestImpl) then,
  ) = __$$BonusProofRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProofType proofType, String content});
}

/// @nodoc
class __$$BonusProofRequestImplCopyWithImpl<$Res>
    extends _$BonusProofRequestCopyWithImpl<$Res, _$BonusProofRequestImpl>
    implements _$$BonusProofRequestImplCopyWith<$Res> {
  __$$BonusProofRequestImplCopyWithImpl(
    _$BonusProofRequestImpl _value,
    $Res Function(_$BonusProofRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonusProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? proofType = null, Object? content = null}) {
    return _then(
      _$BonusProofRequestImpl(
        proofType: null == proofType
            ? _value.proofType
            : proofType // ignore: cast_nullable_to_non_nullable
                  as ProofType,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BonusProofRequestImpl implements _BonusProofRequest {
  const _$BonusProofRequestImpl({
    required this.proofType,
    required this.content,
  });

  factory _$BonusProofRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusProofRequestImplFromJson(json);

  @override
  final ProofType proofType;
  @override
  final String content;

  @override
  String toString() {
    return 'BonusProofRequest(proofType: $proofType, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusProofRequestImpl &&
            (identical(other.proofType, proofType) ||
                other.proofType == proofType) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, proofType, content);

  /// Create a copy of BonusProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusProofRequestImplCopyWith<_$BonusProofRequestImpl> get copyWith =>
      __$$BonusProofRequestImplCopyWithImpl<_$BonusProofRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusProofRequestImplToJson(this);
  }
}

abstract class _BonusProofRequest implements BonusProofRequest {
  const factory _BonusProofRequest({
    required final ProofType proofType,
    required final String content,
  }) = _$BonusProofRequestImpl;

  factory _BonusProofRequest.fromJson(Map<String, dynamic> json) =
      _$BonusProofRequestImpl.fromJson;

  @override
  ProofType get proofType;
  @override
  String get content;

  /// Create a copy of BonusProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusProofRequestImplCopyWith<_$BonusProofRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
