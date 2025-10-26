import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 챗봇 API 서비스
/// 
/// 챗봇 관련 API 호출을 담당하는 서비스입니다.
class ChatbotApiService {
  final NetworkClient _networkClient;

  ChatbotApiService(this._networkClient);

  /// 챗봇 대화 목록 조회
  /// 
  /// [month]: 조회할 월 (YYYY-MM 형식)
  /// 
  /// Returns: 챗봇 대화 목록 (groups 배열)
  Future<Response<Map<String, dynamic>>> getChatbotConversations({
    required String month,
  }) async {
    
    final response = await _networkClient.get<Map<String, dynamic>>(
      '/api/chat',
      queryParameters: {
        'month': month,
      },
    );
    
    return response;
  }

  /// 챗봇 대화 상세 조회
  /// 
  /// [conversationId]: 대화 ID
  /// 
  /// Returns: 대화 상세 정보 (메시지 목록 포함)
  Future<Response<Map<String, dynamic>>> getConversationDetail({
    required String conversationId,
  }) async {
    
    final response = await _networkClient.get<Map<String, dynamic>>(
      '/api/chat/$conversationId',
    );
    
    return response;
  }

  /// 챗봇 메시지 전송
  /// 
  /// [conversationId]: 대화 ID (null이면 새 대화 생성)
  /// [message]: 전송할 메시지
  /// 
  /// Returns: 서버 응답 (conversationId, message 포함)
  Future<Response<Map<String, dynamic>>> sendMessage({
    String? conversationId,
    required String message,
  }) async {
    final requestData = {
      if (conversationId != null) 'conversationId': conversationId,
      'message': message,
    };
    
    return await _networkClient.post<Map<String, dynamic>>(
      '/api/chat',
      data: requestData,
    );
  }
}
