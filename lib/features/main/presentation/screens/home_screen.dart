import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/main_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';

/// 홈 화면 - 사용자 캐릭터 정보와 퀘스트 진행 상황을 표시
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  // 데이터 로드는 MainScreen에서 중앙 집중식으로 관리
  // initState와 _loadData 메서드 제거

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
                        SizedBox(height: isSmallScreen ? 0 : 0), 
                        
                        // Boo avatar placeholder
                        Container(
                          width: isSmallScreen ? 250 : 300, 
                          height: isSmallScreen ? 250 : 300, 
                          child: Image.asset(
                            'assets/images/characters/Character1.png',
                            width: isSmallScreen ? 250 : 300,
                            height: isSmallScreen ? 250 : 300,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              print('이미지 로드 에러: $error');
                              return Icon(Icons.pets, size: isSmallScreen ? 80 : 100, color: AppColors.textHint);
                            },
                          ),
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
                        SizedBox(height: isSmallScreen ? 20 : 28), 
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: characterGrowthState.maybeWhen(
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
                                      ),
                                      const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                                    ],
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
                                    // 상단 제목만 표시 (자세히보기와 화살표 아이콘 제거)
                                    Text(
                                      '퀘스트 진행률',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 18 : 20, 
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
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
                                                    data.currentMissionTitle,
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
                                                    height: isSmallScreen ? 6 : 8, 
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                loading: () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '퀘스트 진행률',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
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
                                  ],
                                ),
                                failure: (failure) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '퀘스트 진행률',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
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
                                              '미션 진행 상황을 불러올 수 없습니다',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final authStorage = await AuthStorageService.getInstance();
                                                final sideJobId = authStorage.getSideJobId();
                                                if (sideJobId != null) {
                                                  ref.read(missionProgressNotifierProvider.notifier).getMissionProgress(sideJobId);
                                                }
                                              },
                                              child: const Text('다시 시도'),
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
                                    const Text(
                                      '퀘스트 진행률',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
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
    return Container(
      color: Colors.white, 
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '홈',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
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
                  icon: const Icon(Icons.settings, color: AppColors.textPrimary),
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
          height: isSmallScreen ? 24 : 28, // 반응형 높이
          child: Stack(
            children: [
              Container(
                height: isSmallScreen ? 24 : 28, // 반응형 높이
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F3FF),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: isSmallScreen ? 24 : 28, 
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
                      fontSize: isSmallScreen ? 10 : 12,
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


