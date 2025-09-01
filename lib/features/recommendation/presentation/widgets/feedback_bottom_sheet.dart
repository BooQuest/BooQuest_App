import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

/// 피드백 수집 바텀 시트
class FeedbackBottomSheet extends StatefulWidget {
  final int sideJobIndex;
  final Future<void> Function(List<String> selectedReasons, String additionalComment) onApply;

  const FeedbackBottomSheet({
    super.key,
    required this.sideJobIndex,
    required this.onApply,
  });

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  final Set<String> _selectedReasons = <String>{};
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  static const List<Map<String, dynamic>> _feedbackOptions = [
    {'label': '주제가 마음에 들지 않아요', 'key': 'low_profitability'},
    {'label': '플랫폼이 마음에 들지 않아요', 'key': 'not_interesting'},
    {'label': '시간이 너무 많이 들어요', 'key': 'too_time_consuming'},
    {'label': '다른걸로 바꿔주세요', 'key': 'change_to_other'},
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

                    // 피드백 옵션들
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // 2열 2행으로 배치 (4개 옵션)
                          for (int row = 0; row < 2; row++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  for (int col = 0; col < 2; col++)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: col == 0 ? 6 : 0,
                                          left: col == 1 ? 6 : 0,
                                        ),
                                        child: _buildFeedbackOption(_feedbackOptions[row * 2 + col]),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
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

                    // 적용하기 버튼
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
                                    await widget.onApply(
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
                                ? const Color(0xFF1976D2)
                                : const Color(0xFFE0E0E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '적용하기',
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
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF666666) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF666666) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
