import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';

class QuestTopBar extends StatelessWidget {
  final bool isSmallScreen;

  const QuestTopBar({
    super.key,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: isSmallScreen ? 44 : 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: isSmallScreen ? 36 : 40,
                height: isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, color: Color(0xFF2C2C2C)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
