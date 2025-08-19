// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sidejob_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SideJobFailure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SideJobFailureCopyWith<SideJobFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideJobFailureCopyWith<$Res> {
  factory $SideJobFailureCopyWith(
    SideJobFailure value,
    $Res Function(SideJobFailure) then,
  ) = _$SideJobFailureCopyWithImpl<$Res, SideJobFailure>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SideJobFailureCopyWithImpl<$Res, $Val extends SideJobFailure>
    implements $SideJobFailureCopyWith<$Res> {
  _$SideJobFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res>
    implements $SideJobFailureCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
    _$NetworkErrorImpl value,
    $Res Function(_$NetworkErrorImpl) then,
  ) = __$$NetworkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$SideJobFailureCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
    _$NetworkErrorImpl _value,
    $Res Function(_$NetworkErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$NetworkErrorImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkErrorImpl implements _NetworkError {
  const _$NetworkErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'SideJobFailure.networkError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) {
    return networkError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) {
    return networkError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class _NetworkError implements SideJobFailure {
  const factory _NetworkError([final String? message]) = _$NetworkErrorImpl;

  @override
  String? get message;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $SideJobFailureCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
    _$ServerErrorImpl value,
    $Res Function(_$ServerErrorImpl) then,
  ) = __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$SideJobFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
    _$ServerErrorImpl _value,
    $Res Function(_$ServerErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$ServerErrorImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ServerErrorImpl implements _ServerError {
  const _$ServerErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'SideJobFailure.serverError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) {
    return serverError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) {
    return serverError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class _ServerError implements SideJobFailure {
  const factory _ServerError([final String? message]) = _$ServerErrorImpl;

  @override
  String? get message;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataErrorImplCopyWith<$Res>
    implements $SideJobFailureCopyWith<$Res> {
  factory _$$DataErrorImplCopyWith(
    _$DataErrorImpl value,
    $Res Function(_$DataErrorImpl) then,
  ) = __$$DataErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DataErrorImplCopyWithImpl<$Res>
    extends _$SideJobFailureCopyWithImpl<$Res, _$DataErrorImpl>
    implements _$$DataErrorImplCopyWith<$Res> {
  __$$DataErrorImplCopyWithImpl(
    _$DataErrorImpl _value,
    $Res Function(_$DataErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$DataErrorImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DataErrorImpl implements _DataError {
  const _$DataErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'SideJobFailure.dataError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataErrorImplCopyWith<_$DataErrorImpl> get copyWith =>
      __$$DataErrorImplCopyWithImpl<_$DataErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) {
    return dataError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) {
    return dataError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) {
    if (dataError != null) {
      return dataError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) {
    return dataError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) {
    return dataError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) {
    if (dataError != null) {
      return dataError(this);
    }
    return orElse();
  }
}

abstract class _DataError implements SideJobFailure {
  const factory _DataError([final String? message]) = _$DataErrorImpl;

  @override
  String? get message;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataErrorImplCopyWith<_$DataErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res>
    implements $SideJobFailureCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
    _$UnknownErrorImpl value,
    $Res Function(_$UnknownErrorImpl) then,
  ) = __$$UnknownErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$SideJobFailureCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
    _$UnknownErrorImpl _value,
    $Res Function(_$UnknownErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$UnknownErrorImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$UnknownErrorImpl implements _UnknownError {
  const _$UnknownErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'SideJobFailure.unknownError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) {
    return unknownError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) {
    return unknownError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class _UnknownError implements SideJobFailure {
  const factory _UnknownError([final String? message]) = _$UnknownErrorImpl;

  @override
  String? get message;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserDataErrorImplCopyWith<$Res>
    implements $SideJobFailureCopyWith<$Res> {
  factory _$$UserDataErrorImplCopyWith(
    _$UserDataErrorImpl value,
    $Res Function(_$UserDataErrorImpl) then,
  ) = __$$UserDataErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UserDataErrorImplCopyWithImpl<$Res>
    extends _$SideJobFailureCopyWithImpl<$Res, _$UserDataErrorImpl>
    implements _$$UserDataErrorImplCopyWith<$Res> {
  __$$UserDataErrorImplCopyWithImpl(
    _$UserDataErrorImpl _value,
    $Res Function(_$UserDataErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$UserDataErrorImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$UserDataErrorImpl implements _UserDataError {
  const _$UserDataErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'SideJobFailure.userDataError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataErrorImplCopyWith<_$UserDataErrorImpl> get copyWith =>
      __$$UserDataErrorImplCopyWithImpl<_$UserDataErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) dataError,
    required TResult Function(String? message) unknownError,
    required TResult Function(String? message) userDataError,
  }) {
    return userDataError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? dataError,
    TResult? Function(String? message)? unknownError,
    TResult? Function(String? message)? userDataError,
  }) {
    return userDataError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? dataError,
    TResult Function(String? message)? unknownError,
    TResult Function(String? message)? userDataError,
    required TResult orElse(),
  }) {
    if (userDataError != null) {
      return userDataError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_DataError value) dataError,
    required TResult Function(_UnknownError value) unknownError,
    required TResult Function(_UserDataError value) userDataError,
  }) {
    return userDataError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_DataError value)? dataError,
    TResult? Function(_UnknownError value)? unknownError,
    TResult? Function(_UserDataError value)? userDataError,
  }) {
    return userDataError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_DataError value)? dataError,
    TResult Function(_UnknownError value)? unknownError,
    TResult Function(_UserDataError value)? userDataError,
    required TResult orElse(),
  }) {
    if (userDataError != null) {
      return userDataError(this);
    }
    return orElse();
  }
}

abstract class _UserDataError implements SideJobFailure {
  const factory _UserDataError([final String? message]) = _$UserDataErrorImpl;

  @override
  String? get message;

  /// Create a copy of SideJobFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDataErrorImplCopyWith<_$UserDataErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
