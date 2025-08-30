// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_proof_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImageProofEntity _$ImageProofEntityFromJson(Map<String, dynamic> json) {
  return _ImageProofEntity.fromJson(json);
}

/// @nodoc
mixin _$ImageProofEntity {
  String get status => throw _privateConstructorUsedError;
  int get additionalExp => throw _privateConstructorUsedError;

  /// Serializes this ImageProofEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageProofEntityCopyWith<ImageProofEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageProofEntityCopyWith<$Res> {
  factory $ImageProofEntityCopyWith(
    ImageProofEntity value,
    $Res Function(ImageProofEntity) then,
  ) = _$ImageProofEntityCopyWithImpl<$Res, ImageProofEntity>;
  @useResult
  $Res call({String status, int additionalExp});
}

/// @nodoc
class _$ImageProofEntityCopyWithImpl<$Res, $Val extends ImageProofEntity>
    implements $ImageProofEntityCopyWith<$Res> {
  _$ImageProofEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? additionalExp = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageProofEntityImplCopyWith<$Res>
    implements $ImageProofEntityCopyWith<$Res> {
  factory _$$ImageProofEntityImplCopyWith(
    _$ImageProofEntityImpl value,
    $Res Function(_$ImageProofEntityImpl) then,
  ) = __$$ImageProofEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int additionalExp});
}

/// @nodoc
class __$$ImageProofEntityImplCopyWithImpl<$Res>
    extends _$ImageProofEntityCopyWithImpl<$Res, _$ImageProofEntityImpl>
    implements _$$ImageProofEntityImplCopyWith<$Res> {
  __$$ImageProofEntityImplCopyWithImpl(
    _$ImageProofEntityImpl _value,
    $Res Function(_$ImageProofEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? additionalExp = null}) {
    return _then(
      _$ImageProofEntityImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalExp: null == additionalExp
            ? _value.additionalExp
            : additionalExp // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageProofEntityImpl implements _ImageProofEntity {
  const _$ImageProofEntityImpl({
    required this.status,
    required this.additionalExp,
  });

  factory _$ImageProofEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageProofEntityImplFromJson(json);

  @override
  final String status;
  @override
  final int additionalExp;

  @override
  String toString() {
    return 'ImageProofEntity(status: $status, additionalExp: $additionalExp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageProofEntityImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.additionalExp, additionalExp) ||
                other.additionalExp == additionalExp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, additionalExp);

  /// Create a copy of ImageProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageProofEntityImplCopyWith<_$ImageProofEntityImpl> get copyWith =>
      __$$ImageProofEntityImplCopyWithImpl<_$ImageProofEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageProofEntityImplToJson(this);
  }
}

abstract class _ImageProofEntity implements ImageProofEntity {
  const factory _ImageProofEntity({
    required final String status,
    required final int additionalExp,
  }) = _$ImageProofEntityImpl;

  factory _ImageProofEntity.fromJson(Map<String, dynamic> json) =
      _$ImageProofEntityImpl.fromJson;

  @override
  String get status;
  @override
  int get additionalExp;

  /// Create a copy of ImageProofEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageProofEntityImplCopyWith<_$ImageProofEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageProofRequest _$ImageProofRequestFromJson(Map<String, dynamic> json) {
  return _ImageProofRequest.fromJson(json);
}

/// @nodoc
mixin _$ImageProofRequest {
  int get stepId => throw _privateConstructorUsedError;

  /// Serializes this ImageProofRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageProofRequestCopyWith<ImageProofRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageProofRequestCopyWith<$Res> {
  factory $ImageProofRequestCopyWith(
    ImageProofRequest value,
    $Res Function(ImageProofRequest) then,
  ) = _$ImageProofRequestCopyWithImpl<$Res, ImageProofRequest>;
  @useResult
  $Res call({int stepId});
}

/// @nodoc
class _$ImageProofRequestCopyWithImpl<$Res, $Val extends ImageProofRequest>
    implements $ImageProofRequestCopyWith<$Res> {
  _$ImageProofRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stepId = null}) {
    return _then(
      _value.copyWith(
            stepId: null == stepId
                ? _value.stepId
                : stepId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageProofRequestImplCopyWith<$Res>
    implements $ImageProofRequestCopyWith<$Res> {
  factory _$$ImageProofRequestImplCopyWith(
    _$ImageProofRequestImpl value,
    $Res Function(_$ImageProofRequestImpl) then,
  ) = __$$ImageProofRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int stepId});
}

/// @nodoc
class __$$ImageProofRequestImplCopyWithImpl<$Res>
    extends _$ImageProofRequestCopyWithImpl<$Res, _$ImageProofRequestImpl>
    implements _$$ImageProofRequestImplCopyWith<$Res> {
  __$$ImageProofRequestImplCopyWithImpl(
    _$ImageProofRequestImpl _value,
    $Res Function(_$ImageProofRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stepId = null}) {
    return _then(
      _$ImageProofRequestImpl(
        stepId: null == stepId
            ? _value.stepId
            : stepId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageProofRequestImpl implements _ImageProofRequest {
  const _$ImageProofRequestImpl({required this.stepId});

  factory _$ImageProofRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageProofRequestImplFromJson(json);

  @override
  final int stepId;

  @override
  String toString() {
    return 'ImageProofRequest(stepId: $stepId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageProofRequestImpl &&
            (identical(other.stepId, stepId) || other.stepId == stepId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stepId);

  /// Create a copy of ImageProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageProofRequestImplCopyWith<_$ImageProofRequestImpl> get copyWith =>
      __$$ImageProofRequestImplCopyWithImpl<_$ImageProofRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageProofRequestImplToJson(this);
  }
}

abstract class _ImageProofRequest implements ImageProofRequest {
  const factory _ImageProofRequest({required final int stepId}) =
      _$ImageProofRequestImpl;

  factory _ImageProofRequest.fromJson(Map<String, dynamic> json) =
      _$ImageProofRequestImpl.fromJson;

  @override
  int get stepId;

  /// Create a copy of ImageProofRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageProofRequestImplCopyWith<_$ImageProofRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
