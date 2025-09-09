import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/domain/entities/sidejob_progress_entity.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

import 'package:booquest/features/quest/presentation/widgets/quest_top_bar.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_progress_card.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_tab_bar.dart';
import 'package:booquest/features/quest/presentation/widgets/planned_quest_card.dart';
import 'package:booquest/features/quest/presentation/widgets/main_quest_card.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_success_popup.dart';
import 'package:booquest/features/quest/presentation/widgets/sidejob_guide_popup.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_completion_dialog.dart';
import 'package:booquest/features/quest/presentation/widgets/experience_boost_popup.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/quest/presentation/screens/next_quest_setup_screen.dart';
import 'package:booquest/features/quest/infrastructure/providers/mission_step_completion_providers.dart';
import 'package:booquest/features/quest/infrastructure/providers/mission_completion_providers.dart';

class QuestScreen extends ConsumerStatefulWidget {
  final VoidCallback? onHomeTabRequested;
  
  const QuestScreen({super.key, this.onHomeTabRequested});

  @override
  ConsumerState<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends ConsumerState<QuestScreen> {
  int _selectedTabIndex = 0; // 0: 진행 중, 1: 예정
  String? _userNickname;
  int? _sideJobId;
  int? _selectedStepId; // 선택된 부퀘스트 스텝 ID 
  bool _isSubQuestExpanded = true; // 부퀘스트 섹션 펼침/접힘 상태

  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final nickname = authStorage.getNickname();
      final sideJobId = authStorage.getSideJobId();
      setState(() {
        _userNickname = nickname;
        _sideJobId = sideJobId;
      });
    } catch (e) {
    }
  }

  /// 진행 상황 텍스트를 반환하는 함수
  String _getProgressText(SideJobProgressEntity data) {
    // 모든 단계가 완료된 경우
    if (data.progressPercent >= 100) {
      return '${data.totalStages}단계 모두 완료 · 축하합니다!';
    }
    // 진행률이 0%가 아닌 경우 (어떤 단계든 진행 중이거나 완료된 상태)
    else if (data.progressPercent > 0) {
      // 진행률을 기반으로 현재 단계 계산
      final currentStage = ((data.progressPercent / 100.0) * data.totalStages).ceil();
      return '$currentStage단계 진행 중 · 목표까지 ${data.totalStages - currentStage}단계 남음';
    }
    // 아직 시작하지 않은 경우
    else {
      return '';
    }
  }

  /// 미션 데이터를 기반으로 진행 상황 텍스트를 반환하는 함수
  String _getProgressTextFromMissions(SideJobProgressEntity data, MissionListState missionState) {
    return missionState.maybeWhen(
      success: (missionData) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMissions = missionData.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
        
        if (inProgressMissions.isNotEmpty) {
          // 진행 중인 미션이 있으면 해당 단계 표시
          final currentOrder = inProgressMissions.first.orderNo ?? 1;
          return '$currentOrder단계 진행 중 · 목표까지 ${data.totalStages - currentOrder}단계 남음';
        }
        
        // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 찾기
        final completedMissions = missionData.missions
            .where((mission) => mission.status == 'COMPLETED')
            .toList()
          ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
        
        if (completedMissions.isNotEmpty) {
          // 완료된 미션이 있으면 해당 단계 완료 표시
          final completedOrder = completedMissions.first.orderNo ?? 1;
          return '$completedOrder단계 완료 · 다음 부업 준비 중';
        }
        
        // 미션이 아예 없는 경우
        return '';
      },
      orElse: () => _getProgressText(data), // 미션 데이터가 없으면 기본 로직 사용
    );
  }

  @override
  Widget build(BuildContext context) {
    final sideJobProgressState = ref.watch(sideJobProgressNotifierProvider);
    final missionListState = ref.watch(missionListNotifierProvider);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, 
              Color(0xFFF5F9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
                children: [
              // Fixed top bar
              QuestTopBar(isSmallScreen: _isSmallScreen),
              SizedBox(height: _isSmallScreen ? 16 : 20),
              // Scrollable content
                  Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: _isSmallScreen ? 16 : 20, 
                    vertical: _isSmallScreen ? 12 : 16
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      QuestProgressCard(
                        state: sideJobProgressState,
                        missionListState: missionListState,
                        userNickname: _userNickname,
                        isSmallScreen: _isSmallScreen,
                      ),
                      SizedBox(height: _isSmallScreen ? 20 : 24),
                      QuestTabBar(
                        selectedTabIndex: _selectedTabIndex,
                        onTabChanged: (index) => setState(() => _selectedTabIndex = index),
                      ),
                      SizedBox(height: _isSmallScreen ? 16 : 20),
                      _selectedTabIndex == 0 
                          ? MainQuestCard(
                              state: missionListState,
                              isSmallScreen: _isSmallScreen,
                              selectedStepId: _selectedStepId,
                              isSubQuestExpanded: _isSubQuestExpanded,
                              onStepSelected: (stepId) => _handleStepSelection(stepId),
                              onSubQuestToggle: () => setState(() => _isSubQuestExpanded = !_isSubQuestExpanded),
                              onSidejobGuide: () => _showSidejobGuidePopup(context),
                              isCompleteButtonEnabled: _isCompleteButtonEnabled,
                              getButtonText: _getButtonText,
                              onButtonTap: _handleButtonTap,
                            )
                          : PlannedQuestCard(
                              state: missionListState,
                              isSmallScreen: _isSmallScreen,
                            ),
                      SizedBox(height: _isSmallScreen ? 16 : 20),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }



  /// 부퀘스트 완료 버튼이 활성화되어야 하는지 확인하는 메서드
  bool _isCompleteButtonEnabled(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          // 부퀘스트가 선택되었거나, 모든 부퀘스트가 완료된 상태면 버튼 활성화
          return _selectedStepId != null || _isAllSubQuestsCompleted(inProgressMission);
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 항상 활성화 (메인 퀘스트 완료 버튼)
            return true;
          }
        }
        return false;
      },
      orElse: () => false,
    );
  }

  /// 모든 부퀘스트가 완료되었는지 확인하는 메서드
  bool _isAllSubQuestsCompleted(dynamic mission) {
    return mission.steps.every((step) => step.status == 'COMPLETED');
  }

  /// 버튼 텍스트를 동적으로 반환하는 메서드
  String _getButtonText(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          if (_isAllSubQuestsCompleted(inProgressMission)) {
            return '메인 퀘스트 완료';
          } else if (_selectedStepId != null) {
            return '부퀘스트 완료하기';
          }
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 메인 퀘스트 완료 버튼 표시
            return '메인 퀘스트 완료';
          }
        }
        return '부퀘스트 완료하기';
      },
      orElse: () => '부퀘스트 완료하기',
    );
  }

  /// 버튼 탭 처리 메서드 (부퀘스트 완료 또는 메인 퀘스트 완료)
  Future<void> _handleButtonTap(BuildContext context, MissionListState state) async {
    state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          if (_isAllSubQuestsCompleted(inProgressMission)) {
            // 모든 부퀘스트가 완료된 상태: 메인 퀘스트 완료 처리
            _handleMainQuestCompletion(context, inProgressMission.id);
          } else if (_selectedStepId != null) {
            // 부퀘스트가 선택된 상태: 부퀘스트 완료 처리
            _handleSelectedStepCompletion(context);
          }
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 메인 퀘스트 완료 처리
            _handleMainQuestCompletion(context, completedMissions.first.id);
          }
        }
      },
      orElse: () {},
    );
  }

  /// 메인 퀘스트 완료 처리
  Future<void> _handleMainQuestCompletion(BuildContext context, int missionId) async {
    try {
      
      // 현재 미션의 orderNo 확인
      final missionListState = ref.read(missionListNotifierProvider);
      int? currentOrderNo;
      
      missionListState.maybeWhen(
        success: (data) {
          final mission = data.missions.firstWhere(
            (m) => m.id == missionId,
            orElse: () => data.missions.first,
          );
          currentOrderNo = mission.orderNo;
        },
        orElse: () {},
      );
      
      // 메인 퀘스트 완료 API 호출
      await ref.read(missionCompletionNotifierProvider.notifier).completeMission(missionId);
      
      // 상태 확인
      final state = ref.read(missionCompletionNotifierProvider);
      
      if (mounted) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            // 5단계 완료인 경우 특별 처리
            if (currentOrderNo == 5) {
              _showFinalQuestCompletionScreen(context, data);
            } else {
              // 일반적인 완료 처리 - 성공 팝업 표시
            _showMainQuestSuccessPopup(context, data);
            }
            
            // 데이터 새로고침은 MainScreen에서 관리
            // 필요시 여기서 특정 API만 호출
          },
          failure: (message) {
            // 실패 시 에러 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('메인 퀘스트 완료 실패: $message'),
                backgroundColor: Colors.red,
              ),
            );
          },
          alreadyCompleted: () {
            // 이미 완료된 메인 퀘스트 - 5단계가 아닌 경우에만 다음 퀘스트 설정 화면으로 이동
            if (currentOrderNo != 5) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NextQuestSetupScreen(
                    onHomeTabRequested: widget.onHomeTabRequested,
                  ),
                ),
              );
            } else {
              // 5단계 완료인 경우 특별 처리
              _showFinalQuestCompletionScreen(context, null);
            }
          },
        );
      }
    } catch (e) {
      // 현재 미션의 orderNo 확인 (catch 블록에서도 필요)
      final missionListState = ref.read(missionListNotifierProvider);
      int? currentOrderNo;
      
      missionListState.maybeWhen(
        success: (data) {
          final mission = data.missions.firstWhere(
            (m) => m.id == missionId,
            orElse: () => data.missions.first,
          );
          currentOrderNo = mission.orderNo;
        },
        orElse: () {},
      );
      
      // 이미 완료된 메인 퀘스트인 경우
      if (e.toString().contains('already-completed')) {
        if (mounted) {
          // 5단계 완료인 경우 특별 처리
          if (currentOrderNo == 5) {
            _showFinalQuestCompletionScreen(context, null);
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NextQuestSetupScreen(
                  onHomeTabRequested: widget.onHomeTabRequested,
                ),
              ),
            );
          }
        }
        return;
      }
      
      // 다른 오류인 경우
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('메인 퀘스트 완료 처리 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 선택된 부퀘스트가 있는지 확인하는 메서드
  bool _hasSelectedSubQuest() {
    return _selectedStepId != null;
  }

  /// 부퀘스트 선택 처리 (라디오 버튼처럼 하나만 선택)
  void _handleStepSelection(int stepId) {
    setState(() {
      if (_selectedStepId == stepId) {
        // 같은 스텝을 다시 클릭하면 선택 해제
        _selectedStepId = null;
      } else {
        // 다른 스텝을 클릭하면 기존 선택 해제하고 새로 선택
        _selectedStepId = stepId;
      }
    });
  }

  /// 선택된 부퀘스트를 완료 처리
  Future<void> _handleSelectedStepCompletion(BuildContext context) async {
    if (_selectedStepId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('완료할 부퀘스트를 선택해주세요.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 퀘스트 완료 확인 다이얼로그 표시
    final result = await QuestCompletionDialog.show(
      context,
      questTitle: '부퀘스트',
      onComplete: () {
        // 빈 콜백 (QuestCompletionDialog에서 자동으로 닫힘)
      },
    );

    // 완료 버튼을 눌렀을 때만 기존 API 로직 실행
    if (result == true) {
      await _completeSelectedStep(context);
    }
  }

  /// 실제 부퀘스트 완료 처리 (기존 로직)
  Future<void> _completeSelectedStep(BuildContext context) async {
    try {
      // 선택된 스텝을 완료 처리
      await ref.read(missionStepCompletionNotifierProvider.notifier).completeStep(
        _selectedStepId!,
        'COMPLETED',
      );

      // 상태 확인
      final state = ref.read(missionStepCompletionNotifierProvider);
      
      if (mounted) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            // 성공 시 ExperienceBoostPopup 표시
            _showExperienceBoostPopup(context, _selectedStepId!);
            
            // 선택 상태 초기화
            setState(() {
              _selectedStepId = null;
            });
            
            // 데이터 새로고침은 MainScreen에서 관리
            // 필요시 여기서 특정 API만 호출
          },
          failure: (message) {
            // 실패 시 에러 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('부퀘스트 완료 실패: $message'),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      }
    } catch (e) {
      print('❌ 부퀘스트 완료 처리 중 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('부퀘스트 완료 처리 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ExperienceBoostPopup 표시
  void _showExperienceBoostPopup(BuildContext context, int stepId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ExperienceBoostPopup(stepId: stepId),
    );
  }

  /// 부퀘스트 성공 팝업 표시
  void _showQuestSuccessPopup(BuildContext context, int stepId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => QuestSuccessPopup(stepId: stepId),
    );
  }

  /// 메인 퀘스트 성공 팝업 표시
  void _showMainQuestSuccessPopup(BuildContext context, dynamic data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCompleteScreen(
          method: 'main_quest',
          content: '메인 퀘스트 완료',
          expReward: data.totalExpReward,
          onHomeTabRequested: widget.onHomeTabRequested,
        ),
      ),
    );
  }

  /// 최종 퀘스트 완료 화면 표시 (5단계 완료 시)
  void _showFinalQuestCompletionScreen(BuildContext context, dynamic data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCompleteScreen(
          method: 'final_quest',
          content: '모든 메인 퀘스트 완료',
          expReward: data?.totalExpReward ?? 50,
          onHomeTabRequested: widget.onHomeTabRequested,
        ),
      ),
    );
  }

  /// 부업 가이드 팝업 표시
  void _showSidejobGuidePopup(BuildContext context) {
    final missionListState = ref.read(missionListNotifierProvider);
    
    missionListState.when(
      initial: () => _showEmptyGuidePopup(context),
      loading: () => _showEmptyGuidePopup(context),
      success: (data) {
        // 현재 진행 중인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        
        if (inProgressMission != null) {
          // 진행 중인 미션이 있으면 해당 미션만 전달
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => SidejobGuidePopup(missions: [inProgressMission]),
          );
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 사용
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) => SidejobGuidePopup(missions: [completedMissions.first]),
          );
        } else {
          _showEmptyGuidePopup(context);
          }
        }
      },
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('부업 가이드 로드 실패: $message'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
  
  /// 빈 가이드 팝업 표시 (데이터가 없을 때)
  void _showEmptyGuidePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const SidejobGuidePopup(missions: []),
    );
  }
}


