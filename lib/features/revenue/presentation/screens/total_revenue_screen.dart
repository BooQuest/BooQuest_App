import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';


/// 총 수익 상세 화면 - 이미지와 동일한 디자인
class TotalRevenueScreen extends StatelessWidget {
  final int totalIncome;
  final String sideJobTitle;
  final VoidCallback? onBack;

  const TotalRevenueScreen({
    super.key,
    required this.totalIncome,
    required this.sideJobTitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 24),
                    // 구분선
                    Container(
                      height: 1,
                      color: const Color(0xFFE0E0E0),
                    ),
                    const SizedBox(height: 24),
                    _buildRevenueList(),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  /// 상단 바 (뒤로가기 + 제목 + 검색)
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
            ),
            const Center(
              child: Text(
                '나의 총 수익',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // 검색 기능 (추후 구현)
                },
                child: const Icon(
                  Icons.search,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 헤더 섹션 (카테고리 태그 + 총 수익 + 추가 버튼)
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단 행: 카테고리 태그와 추가 버튼
        Row(
          children: [
            // 왼쪽: 파란색 카테고리 태그 (이미지와 동일)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3), // 파란색 배경
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                sideJobTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // 흰색 텍스트
                ),
              ),
            ),
            const Spacer(),
            // 오른쪽: 추가 버튼 (이미지와 동일)
            GestureDetector(
              onTap: () {
                // 수익 추가 기능 (추후 구현)
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF9E9E9E), // 회색 배경
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white, // 흰색 + 아이콘
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 총 수익 금액 (중앙 정렬, 이미지와 동일)
        Center(
          child: Text(
            '${_formatCurrency(totalIncome)}원',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  /// 수익 목록 (이미지와 동일하게 6개)
  Widget _buildRevenueList() {
    // 이미지와 동일한 데이터 (6개 항목)
    final revenueEntries = [
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
      {'title': '광고 수익', 'date': '2025.08.19', 'amount': '123,45', 'refNumber': '123,456'},
    ];

    return Column(
      children: revenueEntries.map((entry) => _buildRevenueItem(
        title: entry['title'] as String,
        date: entry['date'] as String,
        amount: entry['amount'] as String,
        refNumber: entry['refNumber'] as String,
      )).toList(),
    );
  }

  /// 수익 아이템 (이미지와 동일한 구조)
  Widget _buildRevenueItem({
    required String title,
    required String date,
    required String amount,
    required String refNumber,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // 왼쪽: 제목과 날짜
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // 오른쪽: 금액과 참조번호
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+$amount원',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2196F3), // 파란색 금액 (이미지와 동일)
                ),
              ),
              const SizedBox(height: 4),
              Text(
                refNumber,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 통화 포맷팅 (123,456 형태)
  String _formatCurrency(int amount) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amount.toString().replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }
}
