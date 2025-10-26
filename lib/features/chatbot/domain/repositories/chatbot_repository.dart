import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';

/// 챗봇 리포지토리 인터페이스
abstract class ChatbotRepository {
  /// 챗봇 대화 목록 조회
  /// 
  /// [month]: 조회할 월 (YYYY-MM 형식)
  /// 
  /// Returns: 챗봇 대화 그룹 목록
  Future<List<ChatbotConversationGroup>> getConversations({
    required String month,
  });

  /// 챗봇 대화 상세 조회
  /// 
  /// [conversationId]: 대화 ID
  /// 
  /// Returns: 대화 상세 정보 (메시지 목록 포함)
  Future<ChatbotConversationDetail> getConversationDetail({
    required String conversationId,
  });

  /// 챗봇 메시지 전송
  /// 
  /// [conversationId]: 대화 ID (null이면 새 대화 생성)
  /// [message]: 전송할 메시지
  /// 
  /// Returns: 서버 응답 데이터
  Future<Map<String, dynamic>> sendMessage({
    String? conversationId,
    required String message,
  });
}
