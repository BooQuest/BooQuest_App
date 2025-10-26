import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/chatbot/domain/chatbot_state.dart';
import 'package:booquest/features/chatbot/domain/repositories/chatbot_repository.dart';
import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';

/// 챗봇 Notifier
class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository;

  ChatbotNotifier(this._repository) : super(const ChatbotState());

  /// 챗봇 대화 목록 조회
  Future<void> getConversations() async {
    try {
      // 현재 월을 YYYY-MM 형식으로 생성
      final now = DateTime.now();
      final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      
      final conversations = await _repository.getConversations(month: month);
      
      // 첫 번째 대화의 ID를 현재 대화 ID로 설정
      String? currentConversationId;
      if (conversations.isNotEmpty && conversations.first.items.isNotEmpty) {
        currentConversationId = conversations.first.items.first.conversationId;
      }
      
      state = state.copyWith(
        conversations: conversations,
        currentConversationId: currentConversationId,
      );
    } catch (e) {
      // 에러 발생 시 상태는 그대로 유지
    }
  }

  /// 챗봇 메시지 전송
  Future<Map<String, dynamic>?> sendMessage(String message) async {
    try {
      final response = await _repository.sendMessage(
        conversationId: state.currentConversationId,
        message: message,
      );
      
      // 응답에서 conversationId 업데이트 (새 대화방 생성 시)
      final newConversationId = response['conversationId'] as String?;
      
      if (newConversationId != null) {
        state = state.copyWith(
          currentConversationId: newConversationId,
        );
      }
      
      return response; // 응답 데이터 반환
    } catch (e) {
      return null;
    }
  }


  /// 현재 대화 목록 반환
  List<ChatbotConversationGroup> get conversations => state.conversations;

  /// 현재 대화 ID 반환
  String? get currentConversationId => state.currentConversationId;
  
  /// 현재 대화 ID 설정
  void setCurrentConversationId(String? conversationId) {
    state = state.copyWith(currentConversationId: conversationId);
  }

  /// 챗봇 대화 상세 조회
  Future<ChatbotConversationDetail> getConversationDetail({
    required String conversationId,
  }) async {
    try {
      final conversationDetail = await _repository.getConversationDetail(
        conversationId: conversationId,
      );
      
      return conversationDetail;
    } catch (e) {
      rethrow;
    }
  }
}
