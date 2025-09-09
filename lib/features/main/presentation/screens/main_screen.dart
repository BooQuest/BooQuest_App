import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/main_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/user_activity_summary_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/user_sidejob_list_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';


/// 메인 화면 (인증된 사용자용) - 탭 기반 레이아웃
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    
    // 화면 목록 초기화 (콜백 함수 포함)
    _screens = [
      HomeScreen(
        onQuestTabRequested: () {
          setState(() {
            _currentIndex = 1; // 퀘스트 탭으로 이동
          });
          _loadDataForTab(1);
        },
      ),
      QuestScreen(
        onHomeTabRequested: () {
          setState(() {
            _currentIndex = 1; // 퀘스트 탭으로 이동
          });
          _loadDataForTab(1);
        },
      ),
      const MyRecordScreen(),
    ];
    
    // 초기 로드 시 홈 화면 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDataForTab(0);
    });
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
    
    // 탭 변경 시 해당 화면의 데이터 로드
    _loadDataForTab(index);
  }
  
  /// 각 탭에 해당하는 데이터 로드
  void _loadDataForTab(int tabIndex) {
    switch (tabIndex) {
      case 0: // 홈 탭
        _loadHomeData();
        break;
      case 1: // 퀘스트 탭
        _loadQuestData();
        break;
      case 2: // 내 기록 탭
        _loadMyRecordData();
        break;
    }
  }
  
  /// 홈 화면 데이터 로드
  void _loadHomeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHomeScreenData();
    });
  }
  
  /// 퀘스트 화면 데이터 로드
  void _loadQuestData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQuestScreenData();
    });
  }
  
  /// 내 기록 화면 데이터 로드
  void _loadMyRecordData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyRecordScreenData();
    });
  }
  
  /// 홈 화면 데이터 로드 구현
  Future<void> _loadHomeScreenData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final sideJobId = authStorage.getSideJobId();
      
      if (sideJobId != null) {
        // sideJobId가 있으면 두 API 동시 호출
        await Future.wait([
          ref.read(characterGrowthNotifierProvider.notifier).getCharacterGrowth(),
          ref.read(missionProgressNotifierProvider.notifier).getMissionProgress(sideJobId),
        ]);
      } else {
        // sideJobId가 없으면 characterGrowth만 호출
        await ref.read(characterGrowthNotifierProvider.notifier).getCharacterGrowth();
      }
    } catch (e) {
      // 에러 무시 (이미 각 화면에서 에러 처리됨)
    }
  }
  
  /// 퀘스트 화면 데이터 로드 구현
  Future<void> _loadQuestScreenData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final sideJobId = authStorage.getSideJobId();
      
      if (sideJobId != null) {
        await Future.wait([
          ref.read(sideJobProgressNotifierProvider.notifier).getSideJobProgress(sideJobId),
          ref.read(missionListNotifierProvider.notifier).getMissionList('', sideJobId),
        ]);
      }
    } catch (e) {
      // 에러 무시 (이미 각 화면에서 에러 처리됨)
    }
  }
  
  /// 내 기록 화면 데이터 로드 구현
  Future<void> _loadMyRecordScreenData() async {
    try {
      await Future.wait([
        ref.read(userActivitySummaryNotifierProvider.notifier).getUserActivitySummary(),
        ref.read(userSideJobListNotifierProvider.notifier).getUserSideJobList(),
      ]);
    } catch (e) {
      // 에러 무시 (이미 각 화면에서 에러 처리됨)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
