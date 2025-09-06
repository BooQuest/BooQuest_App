import 'package:flutter/material.dart';

class CommonBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CommonBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: const Color(0xFFF5F5F5), // 밝은 회색 배경
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/home.png',
            width: 24,
            height: 24,
            color: Colors.grey,
          ),
          activeIcon: Image.asset(
            'assets/images/home.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/quest.png',
            width: 24,
            height: 24,
            color: Colors.grey,
          ),
          activeIcon: Image.asset(
            'assets/images/quest.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          label: '퀘스트',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/myrecord.png',
            width: 24,
            height: 24,
            color: Colors.grey,
          ),
          activeIcon: Image.asset(
            'assets/images/myrecord.png',
            width: 24,
            height: 24,
            color: Colors.black,
          ),
          label: '나의 기록',
        ),
      ],
    );
  }
}
