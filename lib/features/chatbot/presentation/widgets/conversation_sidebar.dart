import 'package:flutter/material.dart';
import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';

/// 대화 목록 사이드바
class ConversationSidebar extends StatelessWidget {
  final List<ChatbotConversationGroup> conversationGroups;
  final String? selectedConversationId;
  final Function(String conversationId) onConversationSelected;
  final VoidCallback onClose;

  const ConversationSidebar({
    super.key,
    required this.conversationGroups,
    this.selectedConversationId,
    required this.onConversationSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withValues(alpha: 0.5), 
      child: SafeArea(
        child: Row(
          children: [
            // 사이드바 컨텐츠
            Container(
              width: 280,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // 헤더
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '대화 목록',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: onClose,
                          icon: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  
                  // 대화 목록
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: conversationGroups.length,
                      itemBuilder: (context, index) {
                        final group = conversationGroups[index];
                        return _buildConversationGroup(group);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // 나머지 공간 (클릭 시 닫기)
            Expanded(
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 대화 그룹 위젯
  Widget _buildConversationGroup(ChatbotConversationGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 월 헤더
        Padding(
          padding: const EdgeInsets.only(left: 4, top: 16, bottom: 8),
          child: Text(
            _formatMonthHeader(group.month),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ),
        
        // 대화 목록
        ...group.items.map((conversation) => _buildConversationItem(conversation)),
        
        const SizedBox(height: 8),
      ],
    );
  }

  /// 대화 아이템 위젯
  Widget _buildConversationItem(ChatbotConversation conversation) {
    final isSelected = selectedConversationId == conversation.conversationId;
    
    return Container(
      width: double.infinity, 
      margin: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onConversationSelected(conversation.conversationId),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey[200] : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              conversation.title,
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  /// 월 헤더 포맷팅
  String _formatMonthHeader(ChatbotMonth month) {
    final now = DateTime.now();
    
    if (month.year == now.year && month.monthValue == now.month) {
      return '오늘';
    } else {
      final monthNames = [
        '1월', '2월', '3월', '4월', '5월', '6월',
        '7월', '8월', '9월', '10월', '11월', '12월'
      ];
      return '${month.year}년 ${monthNames[month.monthValue - 1]}';
    }
  }
}
