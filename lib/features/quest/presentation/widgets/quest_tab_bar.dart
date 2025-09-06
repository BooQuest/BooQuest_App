import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

class QuestTabBar extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;

  const QuestTabBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(0, '진행 중'),
        const SizedBox(width: 20),
        _buildTab(1, '예정'),
      ],
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
