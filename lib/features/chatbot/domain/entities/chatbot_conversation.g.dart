// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatbotConversationImpl _$$ChatbotConversationImplFromJson(
  Map<String, dynamic> json,
) => _$ChatbotConversationImpl(
  conversationId: json['conversationId'] as String,
  title: json['title'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$ChatbotConversationImplToJson(
  _$ChatbotConversationImpl instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'title': instance.title,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$ChatbotMessageImpl _$$ChatbotMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatbotMessageImpl(
      id: (json['id'] as num).toInt(),
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatbotMessageImplToJson(
  _$ChatbotMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': instance.role,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$ChatbotConversationDetailImpl _$$ChatbotConversationDetailImplFromJson(
  Map<String, dynamic> json,
) => _$ChatbotConversationDetailImpl(
  conversationId: json['conversationId'] as String,
  title: json['title'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => ChatbotMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ChatbotConversationDetailImplToJson(
  _$ChatbotConversationDetailImpl instance,
) => <String, dynamic>{
  'conversationId': instance.conversationId,
  'title': instance.title,
  'messages': instance.messages,
};
