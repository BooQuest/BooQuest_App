import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';
import 'package:booquest/features/revenue/application/providers/delete_income_providers.dart';
import 'package:booquest/features/revenue/presentation/widgets/add_income_modal.dart';

/// 수익 항목 옵션 모달 (삭제하기/수정하기)
class IncomeOptionsModal extends ConsumerWidget {
  final IncomeEntity income;
  final VoidCallback? onDeleteSuccess;
  final VoidCallback? onUpdateSuccess;

  const IncomeOptionsModal({
    super.key,
    required this.income,
    this.onDeleteSuccess,
    this.onUpdateSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 상단 핸들
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 버튼들
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                // 삭제하기 버튼
                Expanded(
                  child: _buildOptionButton(
                    icon: Icons.delete_outline,
                    label: '삭제하기',
                    onTap: () => _handleDelete(context, ref),
                  ),
                ),
                const SizedBox(width: 16),
                // 수정하기 버튼
                Expanded(
                  child: _buildOptionButton(
                    icon: Icons.edit_outlined,
                    label: '수정하기',
                    onTap: () => _handleEdit(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 수정 처리
  void _handleEdit(BuildContext context) {
    Navigator.of(context).pop(); // 옵션 모달 닫기
    
    // AddIncomeModal을 update 모드로 열기
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddIncomeModal(
        userSideJobId: income.userSideJobId,
        income: income, // 기존 데이터 전달
        onUpdateSuccess: onUpdateSuccess, // 수정 성공 콜백 전달
      ),
    );
  }

  /// 삭제 처리
  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(deleteIncomeNotifierProvider.notifier).deleteIncome(income.id);
      
      final deleteState = ref.read(deleteIncomeNotifierProvider);
      
      deleteState.when(
        initial: () {},
        loading: () {},
        success: () {
          Navigator.of(context).pop();
          onDeleteSuccess?.call();
        },
        failure: (message) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('삭제 실패: $message')),
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('삭제 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  /// 옵션 버튼 위젯
  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black87,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
