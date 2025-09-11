import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/main_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';

/// 홈 화면 - 사용자 캐릭터 정보와 퀘스트 진행 상황을 표시
class HomeScreen extends ConsumerStatefulWidget {
  final VoidCallback? onQuestTabRequested;
  
  const HomeScreen({super.key, this.onQuestTabRequested});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  // 데이터 로드는 MainScreen에서 중앙 집중식으로 관리
  // initState와 _loadData 메서드 제거

  /// 레벨과 타입에 따라 캐릭터 GIF 파일 경로를 반환하는 함수
  String _getCharacterGifPath(int level) {
    // 레벨 7 이상은 최대 레벨로 제한
    final gifLevel = level > 7 ? 7 : level;
    
    // 로컬 스토리지에서 캐릭터 타입 가져오기
    try {
      final authStorage = AuthStorageService.getInstanceSync();
      final characterType = authStorage.getCharacterType();
      
      // 타입에 따라 다른 GIF 파일 사용 (네이버 클라우드 스토리지 URL 사용)
      if (characterType == 'WHITE') {
        return 'https://kr.object.ncloudstorage.com/booquest-character/char/Standing_${gifLevel}W.gif';
      } else {
        // BLACK이거나 null인 경우 기본값으로 B 사용
        return 'https://kr.object.ncloudstorage.com/booquest-character/char/Standing_${gifLevel}B.gif';
      }
    } catch (e) {
      // 스토리지 접근 실패 시 기본값으로 B 사용
      return 'https://kr.object.ncloudstorage.com/booquest-character/char/Standing_${gifLevel}B.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    // CharacterGrowthState와 MissionProgressState를 관찰합니다
    final characterGrowthState = ref.watch(characterGrowthNotifierProvider);
    final missionProgressState = ref.watch(missionProgressNotifierProvider);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // 위쪽은 완전 흰색
              Color(0xFFE6F3FF), // 아래쪽은 하늘색
            ],
          ),
        ),
        child: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const SizedBox(height: 12),
            Expanded(
              child: Column(
                children: [
                  // 캐릭터 영역을 그라데이션 배경으로 감싸기
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFEFEFF), 
                          Color(0xFFE6F3FF), 
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // TIP 말풍선 추가 (인사말 말풍선 제거)
                        _TipBubble(
                          text: '사람들이 가장 많이 접속하는 시간 ⏰ (저녁 7시~10시)에 콘텐츠를 올려보세요',
                          isSmallScreen: isSmallScreen,
                        ),
                        
                        // Boo avatar placeholder - 레벨별 캐릭터 표시
                        characterGrowthState.maybeWhen(
                          success: (data) {
                            // 레벨 5부터는 높이를 늘려서 전체가 잘 보이도록 함
                            final isHighLevel = data.level >= 5;
                            final containerHeight = isHighLevel 
                                ? (isSmallScreen ? 280.0 : 320.0)  // 레벨 5+ : 높이 증가
                                : (isSmallScreen ? 200.0 : 240.0); // 레벨 4 이하 : 기존 높이
                            final imageHeight = isHighLevel 
                                ? (isSmallScreen ? 320.0 : 360.0)  // 레벨 5+ : 이미지 높이 증가
                                : (isSmallScreen ? 280.0 : 320.0); // 레벨 4 이하 : 기존 이미지 높이
                            
                            return Container(
                              width: isSmallScreen ? 280 : 320, 
                              height: containerHeight,
                              child: ClipRect(
                                child: OverflowBox(
                                  alignment: Alignment.topCenter,
                                  child: Image.network(
                                    _getCharacterGifPath(data.level),
                                    width: isSmallScreen ? 280 : 320,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return SizedBox(
                                        width: isSmallScreen ? 280 : 320,
                                        height: containerHeight,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.pets, size: isSmallScreen ? 80 : 100, color: AppColors.textHint);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          orElse: () {
                            // 기본값은 로딩 아이콘으로 표시
                            return Container(
                              width: isSmallScreen ? 280 : 320, 
                              height: isSmallScreen ? 200 : 240,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textHint),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: isSmallScreen ? 6 : 8), 
                        // Level badge and name - 레벨과 이름을 동적으로 표시
                        characterGrowthState.maybeWhen(
                          success: (data) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1976D2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Lv.${data.level}',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 11 : 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white, 
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                data.name,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          orElse: () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1976D2), 
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 11 : 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white, 
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 20), 
                      ],
                    ),
                  ),

                  // Growth section container - 팝업 스타일 디자인
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30), 
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), 
                            blurRadius: 20,
                            offset: const Offset(0, -5), 
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 드래그 핸들 (팝업 스타일)
                          Container(
                            margin: const EdgeInsets.only(top: 12, bottom: 8),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  characterGrowthState.maybeWhen(
                                    success: (data) => Text(
                                      '${data.name} 성장률',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 18 : 20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    orElse: () => Text(
                                      '성장률',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 18 : 20, 
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                              SizedBox(height: isSmallScreen ? 20 : 24),

                              // Level progress card - 실제 경험치 데이터를 사용
                              characterGrowthState.maybeWhen(
                                success: (data) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.cardBorder, width: 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(isSmallScreen ? 16 : 20), 
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            _LevelChip(label: 'Lv.${data.level}', isSmallScreen: isSmallScreen),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                '레벨업까지 ${data.requiredExpForNextLevel - data.currentExp}EXP 남았어요',
                                                style: TextStyle(
                                                  fontSize: isSmallScreen ? 16 : 18, 
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: isSmallScreen ? 14 : 16), 
                                        _ExpBar(
                                          currentExp: data.currentExp,
                                          requiredExp: data.requiredExpForNextLevel,
                                          isSmallScreen: isSmallScreen,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                loading: () => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.cardBorder, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                failure: (failure) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.cardBorder, width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        const Text(
                                          '데이터를 불러올 수 없습니다',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            ref.read(characterGrowthNotifierProvider.notifier).getCharacterGrowth();
                                          },
                                          child: const Text('다시 시도'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                orElse: () => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.cardBorder, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: isSmallScreen ? 10 : 12), 

                              // Stage card - 미션 진행 상황 데이터를 사용
                              missionProgressState.maybeWhen(
                                success: (data) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 상단 제목과 화살표 아이콘 (클릭 가능)
                                    GestureDetector(
                                      onTap: () {
                                        // 퀘스트 탭으로 이동
                                        widget.onQuestTabRequested?.call();
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '퀘스트 진행률',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 18 : 20, 
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: isSmallScreen ? 20 : 24),
                                    // 퀘스트 진행 카드
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: AppColors.cardBorder, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(isSmallScreen ? 16 : 20), 
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // 퀘스트 정보가 있는 경우와 없는 경우를 구분
                                            if (data.currentMissionOrder != null && data.currentMissionTitle != null) ...[
                                              // 단계 태그와 퀘스트 제목을 가로로 배치
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // 단계 태그
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF2C2C2C),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Text(
                                                      '${data.currentMissionOrder}단계',
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen ? 12 : 13, 
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white, 
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  // 퀘스트 제목
                                                  Expanded(
                                                    child: Text(
                                                      data.currentMissionTitle!,
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen ? 18 : 20,
                                                        fontWeight: FontWeight.w700,
                                                        color: AppColors.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: isSmallScreen ? 14 : 16), 
                                              // 진행률 바와 퍼센트
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: isSmallScreen ? 10 : 12,
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFE6F3FF),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: FractionallySizedBox(
                                                        alignment: Alignment.centerLeft,
                                                        widthFactor: data.missionStepProgressPercentage / 100.0,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xFF4A90E2),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    '${data.missionStepProgressPercentage.toInt()}%',
                                                    style: TextStyle(
                                                      fontSize: isSmallScreen ? 12 : 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.textPrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ] else ...[
                                              // 퀘스트 정보가 없는 경우 - 완료된 상태 또는 로딩 중
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFF8F8F8),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.check_circle_outline,
                                                      size: 24,
                                                      color: AppColors.textSecondary,
                                                    ),
                                                  ),
                                                  SizedBox(width: isSmallScreen ? 8 : 12),
                                                  Expanded(
                                                    child: Text(
                                                      '진행 중인 퀘스트가 없습니다',
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen ? 14 : 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                loading: () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // 퀘스트 탭으로 이동
                                        widget.onQuestTabRequested?.call();
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '퀘스트 진행률',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 18 : 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: isSmallScreen ? 20 : 24),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: AppColors.cardBorder, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                                        child: Column(
                                          children: [
                                            // 로딩 아이콘
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE6F3FF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: isSmallScreen ? 16 : 20),
                                            // 로딩 메시지
                                            Text(
                                              '퀘스트 정보를 불러오는 중...',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 14 : 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textPrimary,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                failure: (failure) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // 퀘스트 탭으로 이동
                                        widget.onQuestTabRequested?.call();
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '퀘스트 진행률',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 18 : 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: isSmallScreen ? 20 : 24),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: AppColors.cardBorder, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                                        child: Column(
                                          children: [
                                            // 에러 아이콘
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFF5F5),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.error_outline,
                                                size: 24,
                                                color: Color(0xFFE53E3E),
                                              ),
                                            ),
                                            SizedBox(height: isSmallScreen ? 16 : 20),
                                            // 에러 메시지
                                            Text(
                                              '퀘스트 정보를 불러올 수 없어요',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 14 : 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textPrimary,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: isSmallScreen ? 8 : 12),
                                            Text(
                                              '잠시 후 다시 시도해주세요',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 12 : 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textSecondary,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: isSmallScreen ? 16 : 20),
                                            // 다시 시도 버튼
                                            GestureDetector(
                                              onTap: () async {
                                                final authStorage = await AuthStorageService.getInstance();
                                                final sideJobId = authStorage.getSideJobId();
                                                if (sideJobId != null) {
                                                  ref.read(missionProgressNotifierProvider.notifier).getMissionProgress(sideJobId);
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF4A90E2),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  '다시 시도',
                                                  style: TextStyle(
                                                    fontSize: isSmallScreen ? 12 : 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                orElse: () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // 퀘스트 탭으로 이동
                                        widget.onQuestTabRequested?.call();
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '퀘스트 진행률',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 18 : 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: isSmallScreen ? 20 : 24),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: AppColors.cardBorder, width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                                        child: Column(
                                          children: [
                                            // 로딩 아이콘
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE6F3FF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: isSmallScreen ? 16 : 20),
                                            // 로딩 메시지
                                            Text(
                                              '퀘스트 정보를 준비하고 있어요',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 14 : 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textPrimary,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Container(
      color: Colors.white, 
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Text(
              'BOOQUEST',
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 24,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF2C2C2C),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 40,
              height: 40,
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
          ],
        ),
      ),
    );
  }
}

class _TipBubble extends StatelessWidget {
  final String text;
  final bool isSmallScreen;
  const _TipBubble({required this.text, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * (isSmallScreen ? 0.7 : 0.6), 
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16, vertical: isSmallScreen ? 10 : 12), // 반응형 패딩
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TIP 태그
              Container(
                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : 8, vertical: isSmallScreen ? 3 : 4), // 반응형 패딩
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'TIP',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 9 : 10, // 반응형 폰트 크기
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8), // 반응형 간격
              // 텍스트를 2줄로 배치
              Text(
                '사람들이 가장 많이 접속하는 시간 ⏰',
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 13, 
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
              SizedBox(height: isSmallScreen ? 1 : 2), 
              Text(
                '(저녁 7시~10시)에 콘텐츠를 올려보세요',
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 13, 
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        // 말풍선 꼬리 추가
        CustomPaint(
          painter: _TipBubbleTailPainter(),
          size: const Size(20, 10),
        ),
      ],
    );
  }
}

class _TipBubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class _LevelChip extends StatelessWidget {
  final String label;
  final bool isSmallScreen;
  const _LevelChip({required this.label, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 12, vertical: isSmallScreen ? 5 : 6), // 반응형 패딩
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C), // 거의 검은색 느낌으로 변경
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isSmallScreen ? 11 : 12, // 반응형 폰트 크기
          fontWeight: FontWeight.w700,
          color: Colors.white, // 흰색 텍스트로 변경
        ),
      ),
    );
  }
}

class _ExpBar extends StatelessWidget {
  final int currentExp;
  final int requiredExp;
  final bool isSmallScreen;
  const _ExpBar({required this.currentExp, required this.requiredExp, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    final double value = currentExp / requiredExp;
    return Column(
      children: [
        Container(
          height: isSmallScreen ? 32 : 36,
          child: Stack(
            children: [
              Container(
                height: isSmallScreen ? 32 : 36, 
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F3FF),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: isSmallScreen ? 32 : 36, 
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2), 
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // EXP 데이터를 게이지바 안에 가로세로 완벽한 중앙정렬
              Positioned.fill(
                child: Center(
                  child: Text(
                    '$currentExp / $requiredExp EXP',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14, 
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


