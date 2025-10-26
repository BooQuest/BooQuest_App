import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';
import 'package:booquest/features/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:booquest/features/chatbot/infrastructure/api/chatbot_api_service.dart';

/// 챗봇 리포지토리 구현
class ChatbotRepositoryImpl implements ChatbotRepository {
  final ChatbotApiService _apiService;

  ChatbotRepositoryImpl(this._apiService);

  @override
  Future<List<ChatbotConversationGroup>> getConversations({
    required String month,
  }) async {
    try {
      final response = await _apiService.getChatbotConversations(month: month);
      
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        final groups = data['groups'] as List<dynamic>;
        
        return groups
            .map((group) => ChatbotConversationGroup.fromJson(group as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('챗봇 대화 목록 조회에 실패했습니다.');
      }
    } catch (e) {
      throw Exception('챗봇 대화 목록 조회 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<ChatbotConversationDetail> getConversationDetail({
    required String conversationId,
  }) async {
    try {
      final response = await _apiService.getConversationDetail(
        conversationId: conversationId,
      );
      
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        return ChatbotConversationDetail.fromJson(data);
      } else {
        throw Exception('대화 상세 조회에 실패했습니다.');
      }
    } catch (e) {
      throw Exception('대화 상세 조회 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> sendMessage({
    String? conversationId,
    required String message,
  }) async {
    try {
      final response = await _apiService.sendMessage(
        conversationId: conversationId,
        message: message,
      );
      
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        return response.data!['data'] as Map<String, dynamic>;
      } else {
        throw Exception('메시지 전송에 실패했습니다.');
      }
    } catch (e) {
      throw Exception('메시지 전송 중 오류가 발생했습니다: $e');
    }
  }
}
