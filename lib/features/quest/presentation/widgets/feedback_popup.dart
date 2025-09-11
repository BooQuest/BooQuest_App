import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

/// 피드백 수집 팝업
/// 재생성하기 버튼 클릭 시 하단에서 올라오는 피드백 수집 팝업창
class FeedbackPopup extends StatefulWidget {
  final Function(List<String> selectedReasons, String additionalComment) onSubmit;
  
  const FeedbackPopup({
    super.key,
    required this.onSubmit,
  });

  @override
  State<FeedbackPopup> createState() => _FeedbackPopupState();
}

class _FeedbackPopupState extends State<FeedbackPopup> {
  final Set<String> _selectedReasons = <String>{};
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  static const List<Map<String, dynamic>> _feedbackOptions = [
    {'label': '너무 어려워요', 'key': 'TOO_DIFFICULT'},
    {'label': '너무 쉬워요', 'key': 'TOO_EASY'},
    {'label': '제가 선택한 부업과 맞지 않아요', 'key': 'NOT_MY_CHOICE'},
    {'label': '목표와 어울리지 않아요', 'key': 'NOT_MATCHING_GOAL'},
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double kb = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: kb > 0 ? kb : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 상단 핸들 바
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // 제목 및 설명
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '더 정확한 추천을 위해,\n어떤 점이 아쉬웠나요?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '아쉬웠던 점을 모두 선택해주세요.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 피드백 옵션들 (동적 레이아웃)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 12, 
                          runSpacing: 12,
                          children: _feedbackOptions.map((option) => 
                            _buildFeedbackOption(option),
                          ).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 추가 코멘트 입력 필드
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _commentController,
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          decoration: const InputDecoration(
                            hintText: '추가로 고려할 점이 있다면 작성해주세요.',
                            hintStyle: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 제출 버튼
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _selectedReasons.isNotEmpty && !_isSubmitting
                              ? () async {
                                  setState(() {
                                    _isSubmitting = true;
                                  });
                                  try {
                                    await widget.onSubmit(
                                        _selectedReasons.toList(), _commentController.text);
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isSubmitting = false;
                                      });
                                    }
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedReasons.isNotEmpty
                                ? AppColors.buttonActive
                                : const Color(0xFFE0E0E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '부퀘스트 재생성',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 로딩 오버레이
            if (_isSubmitting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackOption(Map<String, dynamic> option) {
    final String label = option['label'];
    final String key = option['key'];
    final bool isSelected = _selectedReasons.contains(key);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedReasons.remove(key);
          } else {
            _selectedReasons.add(key);
          }
        });
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 80),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF666666) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF666666) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : const Color(0xFF666666),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
