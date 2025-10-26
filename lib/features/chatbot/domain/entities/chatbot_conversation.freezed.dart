// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatbot_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatbotConversation _$ChatbotConversationFromJson(Map<String, dynamic> json) {
  return _ChatbotConversation.fromJson(json);
}

/// @nodoc
mixin _$ChatbotConversation {
  String get conversationId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatbotConversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotConversationCopyWith<ChatbotConversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotConversationCopyWith<$Res> {
  factory $ChatbotConversationCopyWith(
    ChatbotConversation value,
    $Res Function(ChatbotConversation) then,
  ) = _$ChatbotConversationCopyWithImpl<$Res, ChatbotConversation>;
  @useResult
  $Res call({String conversationId, String title, DateTime createdAt});
}

/// @nodoc
class _$ChatbotConversationCopyWithImpl<$Res, $Val extends ChatbotConversation>
    implements $ChatbotConversationCopyWith<$Res> {
  _$ChatbotConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? title = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotConversationImplCopyWith<$Res>
    implements $ChatbotConversationCopyWith<$Res> {
  factory _$$ChatbotConversationImplCopyWith(
    _$ChatbotConversationImpl value,
    $Res Function(_$ChatbotConversationImpl) then,
  ) = __$$ChatbotConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String conversationId, String title, DateTime createdAt});
}

/// @nodoc
class __$$ChatbotConversationImplCopyWithImpl<$Res>
    extends _$ChatbotConversationCopyWithImpl<$Res, _$ChatbotConversationImpl>
    implements _$$ChatbotConversationImplCopyWith<$Res> {
  __$$ChatbotConversationImplCopyWithImpl(
    _$ChatbotConversationImpl _value,
    $Res Function(_$ChatbotConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? title = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ChatbotConversationImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatbotConversationImpl implements _ChatbotConversation {
  const _$ChatbotConversationImpl({
    required this.conversationId,
    required this.title,
    required this.createdAt,
  });

  factory _$ChatbotConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatbotConversationImplFromJson(json);

  @override
  final String conversationId;
  @override
  final String title;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatbotConversation(conversationId: $conversationId, title: $title, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotConversationImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, title, createdAt);

  /// Create a copy of ChatbotConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotConversationImplCopyWith<_$ChatbotConversationImpl> get copyWith =>
      __$$ChatbotConversationImplCopyWithImpl<_$ChatbotConversationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatbotConversationImplToJson(this);
  }
}

abstract class _ChatbotConversation implements ChatbotConversation {
  const factory _ChatbotConversation({
    required final String conversationId,
    required final String title,
    required final DateTime createdAt,
  }) = _$ChatbotConversationImpl;

  factory _ChatbotConversation.fromJson(Map<String, dynamic> json) =
      _$ChatbotConversationImpl.fromJson;

  @override
  String get conversationId;
  @override
  String get title;
  @override
  DateTime get createdAt;

  /// Create a copy of ChatbotConversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotConversationImplCopyWith<_$ChatbotConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatbotConversationGroup {
  ChatbotMonth get month => throw _privateConstructorUsedError;
  List<ChatbotConversation> get items => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotConversationGroupCopyWith<ChatbotConversationGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotConversationGroupCopyWith<$Res> {
  factory $ChatbotConversationGroupCopyWith(
    ChatbotConversationGroup value,
    $Res Function(ChatbotConversationGroup) then,
  ) = _$ChatbotConversationGroupCopyWithImpl<$Res, ChatbotConversationGroup>;
  @useResult
  $Res call({ChatbotMonth month, List<ChatbotConversation> items});

  $ChatbotMonthCopyWith<$Res> get month;
}

/// @nodoc
class _$ChatbotConversationGroupCopyWithImpl<
  $Res,
  $Val extends ChatbotConversationGroup
>
    implements $ChatbotConversationGroupCopyWith<$Res> {
  _$ChatbotConversationGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? items = null}) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as ChatbotMonth,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ChatbotConversation>,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatbotMonthCopyWith<$Res> get month {
    return $ChatbotMonthCopyWith<$Res>(_value.month, (value) {
      return _then(_value.copyWith(month: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatbotConversationGroupImplCopyWith<$Res>
    implements $ChatbotConversationGroupCopyWith<$Res> {
  factory _$$ChatbotConversationGroupImplCopyWith(
    _$ChatbotConversationGroupImpl value,
    $Res Function(_$ChatbotConversationGroupImpl) then,
  ) = __$$ChatbotConversationGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatbotMonth month, List<ChatbotConversation> items});

  @override
  $ChatbotMonthCopyWith<$Res> get month;
}

/// @nodoc
class __$$ChatbotConversationGroupImplCopyWithImpl<$Res>
    extends
        _$ChatbotConversationGroupCopyWithImpl<
          $Res,
          _$ChatbotConversationGroupImpl
        >
    implements _$$ChatbotConversationGroupImplCopyWith<$Res> {
  __$$ChatbotConversationGroupImplCopyWithImpl(
    _$ChatbotConversationGroupImpl _value,
    $Res Function(_$ChatbotConversationGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? items = null}) {
    return _then(
      _$ChatbotConversationGroupImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as ChatbotMonth,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ChatbotConversation>,
      ),
    );
  }
}

/// @nodoc

class _$ChatbotConversationGroupImpl implements _ChatbotConversationGroup {
  const _$ChatbotConversationGroupImpl({
    required this.month,
    required final List<ChatbotConversation> items,
  }) : _items = items;

  @override
  final ChatbotMonth month;
  final List<ChatbotConversation> _items;
  @override
  List<ChatbotConversation> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ChatbotConversationGroup(month: $month, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotConversationGroupImpl &&
            (identical(other.month, month) || other.month == month) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    month,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotConversationGroupImplCopyWith<_$ChatbotConversationGroupImpl>
  get copyWith =>
      __$$ChatbotConversationGroupImplCopyWithImpl<
        _$ChatbotConversationGroupImpl
      >(this, _$identity);
}

abstract class _ChatbotConversationGroup implements ChatbotConversationGroup {
  const factory _ChatbotConversationGroup({
    required final ChatbotMonth month,
    required final List<ChatbotConversation> items,
  }) = _$ChatbotConversationGroupImpl;

  @override
  ChatbotMonth get month;
  @override
  List<ChatbotConversation> get items;

  /// Create a copy of ChatbotConversationGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotConversationGroupImplCopyWith<_$ChatbotConversationGroupImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatbotMonth {
  int get year => throw _privateConstructorUsedError;
  String get month => throw _privateConstructorUsedError;
  int get monthValue => throw _privateConstructorUsedError;
  bool get leapYear => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotMonthCopyWith<ChatbotMonth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotMonthCopyWith<$Res> {
  factory $ChatbotMonthCopyWith(
    ChatbotMonth value,
    $Res Function(ChatbotMonth) then,
  ) = _$ChatbotMonthCopyWithImpl<$Res, ChatbotMonth>;
  @useResult
  $Res call({int year, String month, int monthValue, bool leapYear});
}

/// @nodoc
class _$ChatbotMonthCopyWithImpl<$Res, $Val extends ChatbotMonth>
    implements $ChatbotMonthCopyWith<$Res> {
  _$ChatbotMonthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthValue = null,
    Object? leapYear = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            monthValue: null == monthValue
                ? _value.monthValue
                : monthValue // ignore: cast_nullable_to_non_nullable
                      as int,
            leapYear: null == leapYear
                ? _value.leapYear
                : leapYear // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotMonthImplCopyWith<$Res>
    implements $ChatbotMonthCopyWith<$Res> {
  factory _$$ChatbotMonthImplCopyWith(
    _$ChatbotMonthImpl value,
    $Res Function(_$ChatbotMonthImpl) then,
  ) = __$$ChatbotMonthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, String month, int monthValue, bool leapYear});
}

/// @nodoc
class __$$ChatbotMonthImplCopyWithImpl<$Res>
    extends _$ChatbotMonthCopyWithImpl<$Res, _$ChatbotMonthImpl>
    implements _$$ChatbotMonthImplCopyWith<$Res> {
  __$$ChatbotMonthImplCopyWithImpl(
    _$ChatbotMonthImpl _value,
    $Res Function(_$ChatbotMonthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthValue = null,
    Object? leapYear = null,
  }) {
    return _then(
      _$ChatbotMonthImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        monthValue: null == monthValue
            ? _value.monthValue
            : monthValue // ignore: cast_nullable_to_non_nullable
                  as int,
        leapYear: null == leapYear
            ? _value.leapYear
            : leapYear // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ChatbotMonthImpl implements _ChatbotMonth {
  const _$ChatbotMonthImpl({
    required this.year,
    required this.month,
    required this.monthValue,
    required this.leapYear,
  });

  @override
  final int year;
  @override
  final String month;
  @override
  final int monthValue;
  @override
  final bool leapYear;

  @override
  String toString() {
    return 'ChatbotMonth(year: $year, month: $month, monthValue: $monthValue, leapYear: $leapYear)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotMonthImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthValue, monthValue) ||
                other.monthValue == monthValue) &&
            (identical(other.leapYear, leapYear) ||
                other.leapYear == leapYear));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, monthValue, leapYear);

  /// Create a copy of ChatbotMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotMonthImplCopyWith<_$ChatbotMonthImpl> get copyWith =>
      __$$ChatbotMonthImplCopyWithImpl<_$ChatbotMonthImpl>(this, _$identity);
}

abstract class _ChatbotMonth implements ChatbotMonth {
  const factory _ChatbotMonth({
    required final int year,
    required final String month,
    required final int monthValue,
    required final bool leapYear,
  }) = _$ChatbotMonthImpl;

  @override
  int get year;
  @override
  String get month;
  @override
  int get monthValue;
  @override
  bool get leapYear;

  /// Create a copy of ChatbotMonth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotMonthImplCopyWith<_$ChatbotMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatbotMessage _$ChatbotMessageFromJson(Map<String, dynamic> json) {
  return _ChatbotMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatbotMessage {
  int get id => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // "user" or "assistant"
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatbotMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotMessageCopyWith<ChatbotMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotMessageCopyWith<$Res> {
  factory $ChatbotMessageCopyWith(
    ChatbotMessage value,
    $Res Function(ChatbotMessage) then,
  ) = _$ChatbotMessageCopyWithImpl<$Res, ChatbotMessage>;
  @useResult
  $Res call({int id, String role, String content, DateTime createdAt});
}

/// @nodoc
class _$ChatbotMessageCopyWithImpl<$Res, $Val extends ChatbotMessage>
    implements $ChatbotMessageCopyWith<$Res> {
  _$ChatbotMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotMessageImplCopyWith<$Res>
    implements $ChatbotMessageCopyWith<$Res> {
  factory _$$ChatbotMessageImplCopyWith(
    _$ChatbotMessageImpl value,
    $Res Function(_$ChatbotMessageImpl) then,
  ) = __$$ChatbotMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String role, String content, DateTime createdAt});
}

/// @nodoc
class __$$ChatbotMessageImplCopyWithImpl<$Res>
    extends _$ChatbotMessageCopyWithImpl<$Res, _$ChatbotMessageImpl>
    implements _$$ChatbotMessageImplCopyWith<$Res> {
  __$$ChatbotMessageImplCopyWithImpl(
    _$ChatbotMessageImpl _value,
    $Res Function(_$ChatbotMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ChatbotMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatbotMessageImpl implements _ChatbotMessage {
  const _$ChatbotMessageImpl({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory _$ChatbotMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatbotMessageImplFromJson(json);

  @override
  final int id;
  @override
  final String role;
  // "user" or "assistant"
  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatbotMessage(id: $id, role: $role, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, content, createdAt);

  /// Create a copy of ChatbotMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotMessageImplCopyWith<_$ChatbotMessageImpl> get copyWith =>
      __$$ChatbotMessageImplCopyWithImpl<_$ChatbotMessageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatbotMessageImplToJson(this);
  }
}

abstract class _ChatbotMessage implements ChatbotMessage {
  const factory _ChatbotMessage({
    required final int id,
    required final String role,
    required final String content,
    required final DateTime createdAt,
  }) = _$ChatbotMessageImpl;

  factory _ChatbotMessage.fromJson(Map<String, dynamic> json) =
      _$ChatbotMessageImpl.fromJson;

  @override
  int get id;
  @override
  String get role; // "user" or "assistant"
  @override
  String get content;
  @override
  DateTime get createdAt;

  /// Create a copy of ChatbotMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotMessageImplCopyWith<_$ChatbotMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatbotConversationDetail _$ChatbotConversationDetailFromJson(
  Map<String, dynamic> json,
) {
  return _ChatbotConversationDetail.fromJson(json);
}

/// @nodoc
mixin _$ChatbotConversationDetail {
  String get conversationId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<ChatbotMessage> get messages => throw _privateConstructorUsedError;

  /// Serializes this ChatbotConversationDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotConversationDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotConversationDetailCopyWith<ChatbotConversationDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotConversationDetailCopyWith<$Res> {
  factory $ChatbotConversationDetailCopyWith(
    ChatbotConversationDetail value,
    $Res Function(ChatbotConversationDetail) then,
  ) = _$ChatbotConversationDetailCopyWithImpl<$Res, ChatbotConversationDetail>;
  @useResult
  $Res call({
    String conversationId,
    String title,
    List<ChatbotMessage> messages,
  });
}

/// @nodoc
class _$ChatbotConversationDetailCopyWithImpl<
  $Res,
  $Val extends ChatbotConversationDetail
>
    implements $ChatbotConversationDetailCopyWith<$Res> {
  _$ChatbotConversationDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotConversationDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? title = null,
    Object? messages = null,
  }) {
    return _then(
      _value.copyWith(
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<ChatbotMessage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotConversationDetailImplCopyWith<$Res>
    implements $ChatbotConversationDetailCopyWith<$Res> {
  factory _$$ChatbotConversationDetailImplCopyWith(
    _$ChatbotConversationDetailImpl value,
    $Res Function(_$ChatbotConversationDetailImpl) then,
  ) = __$$ChatbotConversationDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String conversationId,
    String title,
    List<ChatbotMessage> messages,
  });
}

/// @nodoc
class __$$ChatbotConversationDetailImplCopyWithImpl<$Res>
    extends
        _$ChatbotConversationDetailCopyWithImpl<
          $Res,
          _$ChatbotConversationDetailImpl
        >
    implements _$$ChatbotConversationDetailImplCopyWith<$Res> {
  __$$ChatbotConversationDetailImplCopyWithImpl(
    _$ChatbotConversationDetailImpl _value,
    $Res Function(_$ChatbotConversationDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotConversationDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? title = null,
    Object? messages = null,
  }) {
    return _then(
      _$ChatbotConversationDetailImpl(
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatbotMessage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatbotConversationDetailImpl implements _ChatbotConversationDetail {
  const _$ChatbotConversationDetailImpl({
    required this.conversationId,
    required this.title,
    required final List<ChatbotMessage> messages,
  }) : _messages = messages;

  factory _$ChatbotConversationDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatbotConversationDetailImplFromJson(json);

  @override
  final String conversationId;
  @override
  final String title;
  final List<ChatbotMessage> _messages;
  @override
  List<ChatbotMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatbotConversationDetail(conversationId: $conversationId, title: $title, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotConversationDetailImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    conversationId,
    title,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of ChatbotConversationDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotConversationDetailImplCopyWith<_$ChatbotConversationDetailImpl>
  get copyWith =>
      __$$ChatbotConversationDetailImplCopyWithImpl<
        _$ChatbotConversationDetailImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatbotConversationDetailImplToJson(this);
  }
}

abstract class _ChatbotConversationDetail implements ChatbotConversationDetail {
  const factory _ChatbotConversationDetail({
    required final String conversationId,
    required final String title,
    required final List<ChatbotMessage> messages,
  }) = _$ChatbotConversationDetailImpl;

  factory _ChatbotConversationDetail.fromJson(Map<String, dynamic> json) =
      _$ChatbotConversationDetailImpl.fromJson;

  @override
  String get conversationId;
  @override
  String get title;
  @override
  List<ChatbotMessage> get messages;

  /// Create a copy of ChatbotConversationDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotConversationDetailImplCopyWith<_$ChatbotConversationDetailImpl>
  get copyWith => throw _privateConstructorUsedError;
}
