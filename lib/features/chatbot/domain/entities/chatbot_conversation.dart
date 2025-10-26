import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatbot_conversation.freezed.dart';
part 'chatbot_conversation.g.dart';

/// 챗봇 대화 엔티티
@freezed
class ChatbotConversation with _$ChatbotConversation {
  const factory ChatbotConversation({
    required String conversationId,
    required String title,
    required DateTime createdAt,
  }) = _ChatbotConversation;

  factory ChatbotConversation.fromJson(Map<String, dynamic> json) =>
      _$ChatbotConversationFromJson(json);
}

/// 챗봇 대화 그룹 엔티티
@freezed
class ChatbotConversationGroup with _$ChatbotConversationGroup {
  const factory ChatbotConversationGroup({
    required ChatbotMonth month,
    required List<ChatbotConversation> items,
  }) = _ChatbotConversationGroup;

  factory ChatbotConversationGroup.fromJson(Map<String, dynamic> json) {
    return ChatbotConversationGroup(
      month: ChatbotMonth.fromJson(json['month']), // dynamic으로 전달
      items: (json['items'] as List<dynamic>)
          .map((item) => ChatbotConversation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 챗봇 월 정보 엔티티
@freezed
class ChatbotMonth with _$ChatbotMonth {
  const factory ChatbotMonth({
    required int year,
    required String month,
    required int monthValue,
    required bool leapYear,
  }) = _ChatbotMonth;

  factory ChatbotMonth.fromJson(dynamic json) {
    if (json is String) {
      // "2025-09" 형식의 문자열 처리
      final parts = json.split('-');
      final year = int.parse(parts[0]);
      final monthValue = int.parse(parts[1]);
      final monthNames = [
        'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
        'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
      ];
      
      return ChatbotMonth(
        year: year,
        month: monthNames[monthValue - 1],
        monthValue: monthValue,
        leapYear: _isLeapYear(year),
      );
    } else if (json is Map<String, dynamic>) {
      // 기존 Map 형식 처리
      return ChatbotMonth(
        year: json['year'] as int,
        month: json['month'] as String,
        monthValue: json['monthValue'] as int,
        leapYear: json['leapYear'] as bool,
      );
    } else {
      throw Exception('Invalid month format: $json');
    }
  }

  static bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  factory ChatbotMonth.fromJsonMap(Map<String, dynamic> json) {
    return ChatbotMonth(
      year: json['year'] as int,
      month: json['month'] as String,
      monthValue: json['monthValue'] as int,
      leapYear: json['leapYear'] as bool,
    );
  }
}

/// 챗봇 메시지 엔티티
@freezed
class ChatbotMessage with _$ChatbotMessage {
  const factory ChatbotMessage({
    required int id,
    required String role, // "user" or "assistant"
    required String content,
    required DateTime createdAt,
  }) = _ChatbotMessage;

  factory ChatbotMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatbotMessageFromJson(json);
}

/// 챗봇 대화 상세 엔티티
@freezed
class ChatbotConversationDetail with _$ChatbotConversationDetail {
  const factory ChatbotConversationDetail({
    required String conversationId,
    required String title,
    required List<ChatbotMessage> messages,
  }) = _ChatbotConversationDetail;

  factory ChatbotConversationDetail.fromJson(Map<String, dynamic> json) =>
      _$ChatbotConversationDetailFromJson(json);
}
