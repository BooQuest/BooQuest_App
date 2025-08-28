import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/revenue/application/providers/income_providers.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';
import 'package:booquest/features/revenue/presentation/widgets/add_income_modal.dart';
import 'package:booquest/features/revenue/presentation/widgets/income_options_modal.dart';



/// 총 수익 상세 화면 - 이미지와 동일한 디자인
class TotalRevenueScreen extends ConsumerStatefulWidget {
  final int userSideJobId;
  final String sideJobTitle;
  final VoidCallback? onBack;

  const TotalRevenueScreen({
    super.key,
    required this.userSideJobId,
    required this.sideJobTitle,
    this.onBack,
  });

  @override
  ConsumerState<TotalRevenueScreen> createState() => _TotalRevenueScreenState();
}

class _TotalRevenueScreenState extends ConsumerState<TotalRevenueScreen> {
  int _currentIndex = 2; // MyRecord 탭이 선택된 상태

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuestScreen(),
    const MyRecordScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // userSideJobId와 sideJobTitle 값 출력
    print('TotalRevenueScreen - userSideJobId: ${widget.userSideJobId}');
    print('TotalRevenueScreen - sideJobTitle: ${widget.sideJobTitle}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
            await ref.read(incomeNotifierProvider.notifier).getIncomeList(widget.userSideJobId);
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
    // IndexedStack으로 화면 전환하므로 하단 탭이 유지됨
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Home 화면
            const HomeScreen(),
            // Quest 화면  
            const SizedBox.shrink(),
            // TotalRevenue 화면 (현재 화면)
            _buildTotalRevenueContent(),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  /// TotalRevenue 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildTotalRevenueContent() {
    return Column(
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
    );
  }

  /// 상단 바 (뒤로가기 + 제목 + 검색)
  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                // 뒤로가기 시 콜백 호출
                widget.onBack?.call();
              },
              child: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
          ),
          const Text(
            '총 수익',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
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
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 헤더 섹션 (카테고리 태그, 총 수익 금액)
  Widget _buildHeaderSection() {
    final incomeState = ref.watch(incomeNotifierProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20), // 이미지와 유사한 패딩
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 배경
        borderRadius: BorderRadius.circular(12), // 둥근 모서리
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // 그림자 효과
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 행: 카테고리 태그만
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3), // 파란색 배경
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.sideJobTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white, // 흰색 텍스트
              ),
            ),
          ),
          const SizedBox(height: 16), // 태그와 금액 사이 간격
          // 총 수익 금액과 추가 버튼 (같은 행)
          Row(
            children: [
              // 왼쪽: 총 수익 금액
              Expanded(
                child: incomeState.when(
                  initial: () => const Text(
                    '0원',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  loading: () => const Text(
                    '로딩 중...',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  success: (data) => Text(
                    '${_formatCurrency(data.totalAmount)}원',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  failure: (_) => const Text(
                    '0원',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              // 오른쪽: 추가 버튼
              GestureDetector(
                onTap: () {
                  _showAddIncomeModal(context);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary, // 어두운 회색 배경
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white, // 흰색 + 아이콘
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 수익 목록 (API 데이터 사용)
  Widget _buildRevenueList() {
    final incomeState = ref.watch(incomeNotifierProvider);
    
    return incomeState.when(
      initial: () => const Center(
        child: Text(
          '데이터를 불러오는 중...',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      success: (data) {
        if (data.incomes.isEmpty) {
          return const Center(
            child: Text(
              '등록된 수익이 없습니다.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        // id desc 순서로 정렬
        final sortedIncomes = List<IncomeEntity>.from(data.incomes)
          ..sort((a, b) => b.id.compareTo(a.id));
        
        return Column(
          children: sortedIncomes.map((income) => _buildRevenueItem(
            title: income.title,
            date: income.incomeDate,
            amount: _formatCurrency(income.amount),
            refNumber: income.memo, // memo 데이터 표시
            onTap: () => _showIncomeOptionsModal(context, income),
          )).toList(),
        );
      },
      failure: (_) => const Center(
        child: Text(
          '데이터를 불러오는데 실패했습니다.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }

  /// 수익 아이템 (이미지와 동일한 구조)
  Widget _buildRevenueItem({
    required String title,
    required String date,
    required String amount,
    required String refNumber,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  /// 통화 포맷팅 (123,456 형태)
  String _formatCurrency(int amount) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amount.toString().replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  /// 수익 항목 옵션 모달 표시
  void _showIncomeOptionsModal(BuildContext context, IncomeEntity income) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => IncomeOptionsModal(
        income: income,
        onDeleteSuccess: () {
          // 삭제 성공 시 수익 목록 새로고침
          _loadData();
        },
        onUpdateSuccess: () {
          // 수정 성공 시 수익 목록 새로고침
          _loadData();
        },
      ),
    );
  }

  /// 수익 추가 모달 표시
  void _showAddIncomeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddIncomeModal(userSideJobId: widget.userSideJobId),
    ).then((_) {
      // 모달이 닫힌 후 수익 목록 새로고침
      _loadData();
    });
  }
}
