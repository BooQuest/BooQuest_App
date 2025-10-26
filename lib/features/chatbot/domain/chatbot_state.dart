import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';

part 'chatbot_state.freezed.dart';

/// 챗봇 상태 모델
@freezed
class ChatbotState with _$ChatbotState {
  const factory ChatbotState({
    @Default([]) List<ChatbotConversationGroup> conversations,
    String? currentConversationId, // 현재 활성 대화 ID
  }) = _ChatbotState;

  const ChatbotState._();
}
