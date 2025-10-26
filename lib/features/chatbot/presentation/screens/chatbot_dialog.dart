import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/chatbot/application/chatbot_notifier.dart';
import 'package:booquest/features/chatbot/domain/entities/chatbot_conversation.dart';
import 'package:booquest/features/chatbot/infrastructure/providers/chatbot_providers.dart';
import 'package:booquest/features/chatbot/presentation/widgets/conversation_sidebar.dart';

/// 챗봇 다이얼로그 화면
/// 전체 화면을 덮는 모달 형태의 챗봇 인터페이스
class ChatbotDialog extends StatefulWidget {
  const ChatbotDialog({super.key});

  @override
  State<ChatbotDialog> createState() => _ChatbotDialogState();
}

class _ChatbotDialogState extends State<ChatbotDialog> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  double _currentHeight = 0.8; // 현재 높이 (0.0 ~ 1.0) - 80% 시작
  bool _hasText = false; // 입력 상태 관리
  bool _isLoadingConversations = false; // 대화 목록 로딩 상태
  bool _isLoadingMessages = false; // 메시지 로딩 상태
  List<ChatbotMessage> _currentMessages = []; // 현재 대화의 메시지들
  bool _showSidebar = false; // 사이드바 표시 상태

  // 전역 상태 관리 (챗봇 다이얼로그가 닫혀도 유지)
  static List<ChatbotConversationGroup> _globalConversationGroups = [];
  static String? _globalCurrentConversationId;
  static bool _globalConversationsLoaded = false;

  // 챗봇 Notifier 인스턴스
  ChatbotNotifier? _chatbotNotifier;

  @override
  void initState() {
    super.initState();
    
    // 챗봇 Notifier 초기화
    _initializeChatbotNotifier();
    
    // 텍스트 변경 리스너 추가
    _messageController.addListener(() {
      setState(() {
        _hasText = _messageController.text.trim().isNotEmpty;
      });
    });
    
    // 애니메이션 컨트롤러 초기화
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 0.8,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // 초기 데이터 로드
    _loadInitialData();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 챗봇 Notifier 초기화
  Future<void> _initializeChatbotNotifier() async {
    _chatbotNotifier = await createChatbotNotifier();
    // 초기 데이터 로드
    await _loadInitialData();
  }

  /// 초기 데이터 로드
  Future<void> _loadInitialData() async {
    if (_chatbotNotifier == null) return;
    
    // 대화 목록이 이미 로드되었는지 확인
    if (!_globalConversationsLoaded) {
      await _loadConversations();
    } else {
      // 이미 로드된 경우 최신 대화 로드
      await _loadLatestConversation();
    }
  }

  /// 대화 목록 로드
  Future<void> _loadConversations() async {
    if (_chatbotNotifier == null) return;
    
    setState(() {
      _isLoadingConversations = true;
    });

    try {
      await _chatbotNotifier!.getConversations();
      
      // 전역 상태에 저장
      _globalConversationGroups = _chatbotNotifier!.conversations;
      _globalConversationsLoaded = true;
      
      // 최신 대화 로드
      await _loadLatestConversation();
    } catch (e) {
      // 에러 처리
    } finally {
      setState(() {
        _isLoadingConversations = false;
      });
    }
  }

  /// 최신 대화 로드
  Future<void> _loadLatestConversation() async {
    if (_globalConversationGroups.isEmpty) return;

    // 가장 최근 대화 찾기
    ChatbotConversation? latestConversation;
    for (final group in _globalConversationGroups) {
      if (group.items.isNotEmpty) {
        latestConversation = group.items.first;
        break;
      }
    }

    if (latestConversation != null) {
      await _loadConversationMessages(latestConversation.conversationId);
    }
  }

  /// 특정 대화의 메시지 로드
  Future<void> _loadConversationMessages(String conversationId) async {
    if (_chatbotNotifier == null) return;
    
    setState(() {
      _isLoadingMessages = true;
    });

    try {
      final conversationDetail = await _chatbotNotifier!.getConversationDetail(
        conversationId: conversationId,
      );
      
      // 전역 상태 업데이트
      _globalCurrentConversationId = conversationId;
      _chatbotNotifier!.setCurrentConversationId(conversationId);
      
      // 메시지 업데이트 (수정 가능한 리스트로 복사)
      setState(() {
        _currentMessages = List<ChatbotMessage>.from(conversationDetail.messages);
      });
      
      // 스크롤을 맨 아래로
      _scrollToBottom();
    } catch (e) {
      // 에러 처리
    } finally {
      setState(() {
        _isLoadingMessages = false;
      });
    }
  }

  /// 메시지 전송
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // 키보드 닫기
    FocusScope.of(context).unfocus();

    // 사용자 메시지 즉시 추가
    setState(() {
      _currentMessages.add(ChatbotMessage(
        id: DateTime.now().millisecondsSinceEpoch,
        role: 'user',
        content: text,
        createdAt: DateTime.now(),
      ));
      _messageController.clear();
      
      // 로딩 메시지 추가
      _currentMessages.add(ChatbotMessage(
        id: DateTime.now().millisecondsSinceEpoch + 1,
        role: 'assistant',
        content: '...',
        createdAt: DateTime.now(),
      ));
    });

    // 스크롤을 맨 아래로
    _scrollToBottom();

    // API 호출
    _sendMessageToApi(text);
  }

  /// API로 메시지 전송
  Future<void> _sendMessageToApi(String message) async {
    if (_chatbotNotifier == null) return;
    
    try {
      final response = await _chatbotNotifier!.sendMessage(message);
      
      if (response != null) {
        // 새로운 대화 ID가 있으면 업데이트
        final newConversationId = response['conversationId'] as String?;
        if (newConversationId != null && newConversationId != _globalCurrentConversationId) {
          // 새로운 대화방이 생성된 경우 - 대화 목록 다시 로드
          _globalCurrentConversationId = newConversationId;
          _loadConversations(); // 대화 목록 다시 로드
        }

        // 로딩 메시지를 실제 응답으로 교체
        setState(() {
          _currentMessages.removeLast(); // "..." 제거
          _currentMessages.add(ChatbotMessage(
            id: DateTime.now().millisecondsSinceEpoch,
            role: 'assistant',
            content: response['message'] as String? ?? '죄송합니다. 응답을 생성할 수 없습니다.',
            createdAt: DateTime.now(),
          ));
        });
      } else {
        // 에러 메시지로 교체
        setState(() {
          _currentMessages.removeLast(); // "..." 제거
          _currentMessages.add(ChatbotMessage(
            id: DateTime.now().millisecondsSinceEpoch,
            role: 'assistant',
            content: '죄송합니다. 일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해 주세요.',
            createdAt: DateTime.now(),
          ));
        });
      }
    } catch (e) {
      // 에러 메시지로 교체
      setState(() {
        _currentMessages.removeLast(); // "..." 제거
        _currentMessages.add(ChatbotMessage(
          id: DateTime.now().millisecondsSinceEpoch,
          role: 'assistant',
          content: '죄송합니다. 일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해 주세요.',
          createdAt: DateTime.now(),
        ));
      });
    }

    // 스크롤을 맨 아래로
    _scrollToBottom();
  }

  /// 스크롤을 맨 아래로 이동
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 높이 애니메이션
  void _animateToHeight(double targetHeight) {
    _currentHeight = targetHeight;
    _heightAnimation = Tween<double>(
      begin: _heightAnimation.value,
      end: targetHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom; // 키보드 높이
    
    // 키보드가 켜지면 자동으로 전체화면으로 변경
    if (viewInsets > 0 && _currentHeight < 1.0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _animateToHeight(1.0);
        }
      });
    }
    
    return Stack(
      children: [
        // 메인 챗봇 다이얼로그
        GestureDetector(
          onPanUpdate: (details) {
            // 드래그 감지 - 실시간으로 따라오도록
            // 드래그 감도를 조정하여 위/아래 동일하게 반응하도록
            final sensitivity = 3.0; // 감도 조정 (위로 드래그 개선)
            final delta = -details.delta.dy / screenHeight * sensitivity; // 위로 드래그하면 양수
            setState(() {
              _currentHeight = (_currentHeight + delta).clamp(0.8, 1.0);
            });
          },
          onPanEnd: (details) {
            // 드래그 끝날 때 스냅 - 80%와 100%만 가능
            double targetHeight;
            targetHeight = _currentHeight < 0.9 ? 0.8 : 1.0;

            _animateToHeight(targetHeight);
          },
          child: GestureDetector(
            onTap: () {
              // 챗봇 팝업창 전체 터치 시 키보드 닫기
              FocusScope.of(context).unfocus();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: screenHeight * _currentHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(bottom: viewInsets > 0 ? viewInsets : 0),
                child: Column(
                  children: [
                    // 상단 드래그 핸들
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    
                    // 상단 헤더
                    _buildHeader(),
                    
                    // 메인 콘텐츠 영역
                    Expanded(
                      child: _buildMainContent(),
                    ),
                    
                    // 제안 태그 영역 (항상 표시)
                    _buildSuggestionTags(),
                    
                    // 하단 입력 영역
                    _buildInputArea(),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // 사이드바 (대화 목록) - 전체 화면을 덮음 (헤더 포함)
        if (_showSidebar)
          Positioned.fill(
            child: ConversationSidebar(
              conversationGroups: _globalConversationGroups,
              selectedConversationId: _globalCurrentConversationId,
              onConversationSelected: (conversationId) {
                setState(() {
                  _showSidebar = false;
                });
                _loadConversationMessages(conversationId);
              },
              onClose: () {
                setState(() {
                  _showSidebar = false;
                });
              },
            ),
          ),
      ],
    );
  }

  /// 상단 헤더
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white, // 헤더를 원래대로 흰색으로 복원
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // 햄버거 메뉴 (대화 목록 토글)
          IconButton(
            onPressed: () {
              setState(() {
                _showSidebar = !_showSidebar;
              });
            },
            icon: Icon(
              _showSidebar ? Icons.close : Icons.menu,
              color: const Color(0xFF333333),
              size: 24,
            ),
          ),
          
          const Spacer(),
          
          // 제목
          const Text(
            'AI 부업코치',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          
          const Spacer(),
          
          // 닫기 버튼
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Color(0xFF333333),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  /// 메인 콘텐츠 영역
  Widget _buildMainContent() {
    // 대화 목록 로딩 중
    if (_isLoadingConversations) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 대화 목록이 비어있고 메시지도 없는 경우 - 환영 화면
    if (_globalConversationGroups.isEmpty && _currentMessages.isEmpty) {
      return _buildWelcomeScreen();
    }

    // 메시지 로딩 중
    if (_isLoadingMessages) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 메시지가 있는 경우 - 메시지 리스트
    if (_currentMessages.isNotEmpty) {
      return _buildMessageList();
    }

    // 대화 목록은 있지만 메시지가 없는 경우 - 환영 화면
    if (_globalConversationGroups.isNotEmpty) {
      return _buildWelcomeScreen();
    }

    // 기본 환영 화면
    return _buildWelcomeScreen();
  }

  /// 환영 화면 (첫 번째 메시지만 있을 때)
  Widget _buildWelcomeScreen() {
    return FutureBuilder<String>(
      future: _getNickname(),
      builder: (context, snapshot) {
        final nickname = snapshot.data ?? '사용자';
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40), // 상단 여백
                // 챗봇 아바타 (버튼과 동일한 디자인)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF4BAFFF), 
                          Color(0xFF3A9FE6), 
                        ],
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/chatbot.svg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // 환영 메시지
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    '안녕하세요, $nickname 님\n부업 활동에서\n가장 궁금한 건 뭐예요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 40), // 하단 여백
              ],
            ),
          ),
        );
      },
    );
  }

  /// 닉네임 가져오기
  Future<String> _getNickname() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      return authStorage.getNickname() ?? '사용자';
    } catch (e) {
      return '사용자';
    }
  }

  /// 메시지 리스트
  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _currentMessages.length,
      itemBuilder: (context, index) {
        final message = _currentMessages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  /// 메시지 말풍선
  Widget _buildMessageBubble(ChatbotMessage message) {
    final isUser = message.role == 'user';
    final isLoading = message.content == '...';
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              // 봇 아바타
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFF357ABD),
                    ],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/chatbot.svg',
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isUser ? const Color(0xFF4A90E2) : Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUser ? 16 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 16),
                  ),
                ),
                child: isLoading
                    ? _buildLoadingDots()
                    : Text(
                        message.content,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 로딩 애니메이션 (점 3개)
  Widget _buildLoadingDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: _buildDot(value, index * 0.2),
            );
          },
        );
      }),
    );
  }

  /// 개별 점 애니메이션
  Widget _buildDot(double value, double delay) {
    final opacity = (value - delay).clamp(0.0, 1.0);
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.grey[600]?.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  /// 제안 태그 영역
  Widget _buildSuggestionTags() {
    final suggestionTags = [
      {
        'icon': Icons.videocam,
        'text': '짧고 임팩트 있는 릴스 촬영 방법',
        'color': Colors.pink,
      },
      {
        'icon': Icons.track_changes,
        'text': '유튜브 채널 방향성 잡기',
        'color': Colors.red,
      },
      {
        'icon': Icons.trending_up,
        'text': '빠르게 배우는 트렌드 분석',
        'color': Colors.green,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: suggestionTags.map((tag) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _sendSuggestionMessage(tag['text'] as String),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tag['icon'] as IconData,
                        size: 18,
                        color: tag['color'] as Color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tag['text'] as String,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 제안 태그 메시지 전송
  void _sendSuggestionMessage(String message) {
    _messageController.text = message;
    _sendMessage();
  }

  /// 하단 입력 영역
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          // 입력 필드와 전송 버튼 (전체 너비)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: '무엇이든 물어보세요',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _hasText ? _sendMessage : null,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasText 
                          ? null // 그라데이션 사용
                          : Colors.grey[400], // 회색 사용
                      gradient: _hasText 
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF4A90E2),
                                Color(0xFF357ABD),
                              ],
                            )
                          : null,
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: _hasText ? Colors.white : Colors.grey[600],
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // AI 고지 사항
          Text(
            'AI는 실수 할 수 있습니다. 중요한 정보는 재차 확인하세요',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}