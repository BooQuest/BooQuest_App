// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatbot_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatbotState {
  List<ChatbotConversationGroup> get conversations =>
      throw _privateConstructorUsedError;
  String? get currentConversationId => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotStateCopyWith<ChatbotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotStateCopyWith<$Res> {
  factory $ChatbotStateCopyWith(
    ChatbotState value,
    $Res Function(ChatbotState) then,
  ) = _$ChatbotStateCopyWithImpl<$Res, ChatbotState>;
  @useResult
  $Res call({
    List<ChatbotConversationGroup> conversations,
    String? currentConversationId,
  });
}

/// @nodoc
class _$ChatbotStateCopyWithImpl<$Res, $Val extends ChatbotState>
    implements $ChatbotStateCopyWith<$Res> {
  _$ChatbotStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? currentConversationId = freezed,
  }) {
    return _then(
      _value.copyWith(
            conversations: null == conversations
                ? _value.conversations
                : conversations // ignore: cast_nullable_to_non_nullable
                      as List<ChatbotConversationGroup>,
            currentConversationId: freezed == currentConversationId
                ? _value.currentConversationId
                : currentConversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotStateImplCopyWith<$Res>
    implements $ChatbotStateCopyWith<$Res> {
  factory _$$ChatbotStateImplCopyWith(
    _$ChatbotStateImpl value,
    $Res Function(_$ChatbotStateImpl) then,
  ) = __$$ChatbotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatbotConversationGroup> conversations,
    String? currentConversationId,
  });
}

/// @nodoc
class __$$ChatbotStateImplCopyWithImpl<$Res>
    extends _$ChatbotStateCopyWithImpl<$Res, _$ChatbotStateImpl>
    implements _$$ChatbotStateImplCopyWith<$Res> {
  __$$ChatbotStateImplCopyWithImpl(
    _$ChatbotStateImpl _value,
    $Res Function(_$ChatbotStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
    Object? currentConversationId = freezed,
  }) {
    return _then(
      _$ChatbotStateImpl(
        conversations: null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<ChatbotConversationGroup>,
        currentConversationId: freezed == currentConversationId
            ? _value.currentConversationId
            : currentConversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatbotStateImpl extends _ChatbotState {
  const _$ChatbotStateImpl({
    final List<ChatbotConversationGroup> conversations = const [],
    this.currentConversationId,
  }) : _conversations = conversations,
       super._();

  final List<ChatbotConversationGroup> _conversations;
  @override
  @JsonKey()
  List<ChatbotConversationGroup> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final String? currentConversationId;

  @override
  String toString() {
    return 'ChatbotState(conversations: $conversations, currentConversationId: $currentConversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotStateImpl &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ) &&
            (identical(other.currentConversationId, currentConversationId) ||
                other.currentConversationId == currentConversationId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conversations),
    currentConversationId,
  );

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      __$$ChatbotStateImplCopyWithImpl<_$ChatbotStateImpl>(this, _$identity);
}

abstract class _ChatbotState extends ChatbotState {
  const factory _ChatbotState({
    final List<ChatbotConversationGroup> conversations,
    final String? currentConversationId,
  }) = _$ChatbotStateImpl;
  const _ChatbotState._() : super._();

  @override
  List<ChatbotConversationGroup> get conversations;
  @override
  String? get currentConversationId;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
