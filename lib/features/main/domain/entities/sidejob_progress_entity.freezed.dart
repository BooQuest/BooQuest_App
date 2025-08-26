// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidejob_progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SideJobProgressEntity _$SideJobProgressEntityFromJson(
  Map<String, dynamic> json,
) {
  return _SideJobProgressEntity.fromJson(json);
}

/// @nodoc
mixin _$SideJobProgressEntity {
  String get title => throw _privateConstructorUsedError;
  int get progressPercent => throw _privateConstructorUsedError;
  int get currentOrder => throw _privateConstructorUsedError;
  int get totalStages => throw _privateConstructorUsedError;

  /// Serializes this SideJobProgressEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SideJobProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SideJobProgressEntityCopyWith<SideJobProgressEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideJobProgressEntityCopyWith<$Res> {
  factory $SideJobProgressEntityCopyWith(
    SideJobProgressEntity value,
    $Res Function(SideJobProgressEntity) then,
  ) = _$SideJobProgressEntityCopyWithImpl<$Res, SideJobProgressEntity>;
  @useResult
  $Res call({
    String title,
    int progressPercent,
    int currentOrder,
    int totalStages,
  });
}

/// @nodoc
class _$SideJobProgressEntityCopyWithImpl<
  $Res,
  $Val extends SideJobProgressEntity
>
    implements $SideJobProgressEntityCopyWith<$Res> {
  _$SideJobProgressEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SideJobProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? progressPercent = null,
    Object? currentOrder = null,
    Object? totalStages = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            progressPercent: null == progressPercent
                ? _value.progressPercent
                : progressPercent // ignore: cast_nullable_to_non_nullable
                      as int,
            currentOrder: null == currentOrder
                ? _value.currentOrder
                : currentOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStages: null == totalStages
                ? _value.totalStages
                : totalStages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SideJobProgressEntityImplCopyWith<$Res>
    implements $SideJobProgressEntityCopyWith<$Res> {
  factory _$$SideJobProgressEntityImplCopyWith(
    _$SideJobProgressEntityImpl value,
    $Res Function(_$SideJobProgressEntityImpl) then,
  ) = __$$SideJobProgressEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    int progressPercent,
    int currentOrder,
    int totalStages,
  });
}

/// @nodoc
class __$$SideJobProgressEntityImplCopyWithImpl<$Res>
    extends
        _$SideJobProgressEntityCopyWithImpl<$Res, _$SideJobProgressEntityImpl>
    implements _$$SideJobProgressEntityImplCopyWith<$Res> {
  __$$SideJobProgressEntityImplCopyWithImpl(
    _$SideJobProgressEntityImpl _value,
    $Res Function(_$SideJobProgressEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? progressPercent = null,
    Object? currentOrder = null,
    Object? totalStages = null,
  }) {
    return _then(
      _$SideJobProgressEntityImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        progressPercent: null == progressPercent
            ? _value.progressPercent
            : progressPercent // ignore: cast_nullable_to_non_nullable
                  as int,
        currentOrder: null == currentOrder
            ? _value.currentOrder
            : currentOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStages: null == totalStages
            ? _value.totalStages
            : totalStages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SideJobProgressEntityImpl implements _SideJobProgressEntity {
  const _$SideJobProgressEntityImpl({
    required this.title,
    required this.progressPercent,
    required this.currentOrder,
    required this.totalStages,
  });

  factory _$SideJobProgressEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SideJobProgressEntityImplFromJson(json);

  @override
  final String title;
  @override
  final int progressPercent;
  @override
  final int currentOrder;
  @override
  final int totalStages;

  @override
  String toString() {
    return 'SideJobProgressEntity(title: $title, progressPercent: $progressPercent, currentOrder: $currentOrder, totalStages: $totalStages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SideJobProgressEntityImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.currentOrder, currentOrder) ||
                other.currentOrder == currentOrder) &&
            (identical(other.totalStages, totalStages) ||
                other.totalStages == totalStages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    progressPercent,
    currentOrder,
    totalStages,
  );

  /// Create a copy of SideJobProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SideJobProgressEntityImplCopyWith<_$SideJobProgressEntityImpl>
  get copyWith =>
      __$$SideJobProgressEntityImplCopyWithImpl<_$SideJobProgressEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SideJobProgressEntityImplToJson(this);
  }
}

abstract class _SideJobProgressEntity implements SideJobProgressEntity {
  const factory _SideJobProgressEntity({
    required final String title,
    required final int progressPercent,
    required final int currentOrder,
    required final int totalStages,
  }) = _$SideJobProgressEntityImpl;

  factory _SideJobProgressEntity.fromJson(Map<String, dynamic> json) =
      _$SideJobProgressEntityImpl.fromJson;

  @override
  String get title;
  @override
  int get progressPercent;
  @override
  int get currentOrder;
  @override
  int get totalStages;

  /// Create a copy of SideJobProgressEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SideJobProgressEntityImplCopyWith<_$SideJobProgressEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
