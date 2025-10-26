import 'package:booquest/features/chatbot/application/chatbot_notifier.dart';
import 'package:booquest/features/chatbot/infrastructure/repositories/chatbot_repository_impl.dart';
import 'package:booquest/features/chatbot/infrastructure/api/chatbot_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// ChatbotNotifier 생성 헬퍼 함수
/// 
/// 챗봇 관련 모든 의존성을 생성하고 ChatbotNotifier 인스턴스를 반환합니다.
/// AuthStorageService → NetworkClient → ChatbotApiService → ChatbotRepository → ChatbotNotifier 순으로 생성됩니다.
Future<ChatbotNotifier> createChatbotNotifier() async {
  final authStorageService = await AuthStorageService.getInstance();
  final networkClient = NetworkClient(authStorageService);
  final apiService = ChatbotApiService(networkClient);
  final repository = ChatbotRepositoryImpl(apiService);
  return ChatbotNotifier(repository);
}
