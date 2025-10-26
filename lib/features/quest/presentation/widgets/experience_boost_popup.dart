import 'dart:io'; // Platform 사용을 위해 추가
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/presentation/screens/quest_verification_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/missions/infrastructure/providers/mission_providers.dart';
import 'package:booquest/features/missions/domain/entities/bonus_ad_request_data.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 경험치 부스트 팝업 위젯 (광고 포함)
class ExperienceBoostPopup extends ConsumerStatefulWidget {
  final int stepId;
  final bool leveledUp;
  final int? currentLevel;

  const ExperienceBoostPopup({
    super.key, 
    required this.stepId,
    this.leveledUp = false,
    this.currentLevel,
  });

  @override
  ConsumerState<ExperienceBoostPopup> createState() => _ExperienceBoostPopupState();
}

class _ExperienceBoostPopupState extends ConsumerState<ExperienceBoostPopup> {
  RewardedAd? _rewardedAd;
  bool _isAdLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    // 플랫폼별 실제 광고 ID 설정
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-4954826018130837/2011476584' // Android 실제 ID
        : 'ca-app-pub-4954826018130837/2943384493'; // iOS 실제 ID
        
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoading = false;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            _rewardedAd = null;
            _isAdLoading = false;
          });
        },
      ),
    );
  }

  Future<void> _handleRewardAd() async {
    if (_rewardedAd == null) {
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewardedAd(); // 광고 재로딩
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadRewardedAd();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) async {

        Navigator.of(context).pop(); // 팝업 닫기

        // 보너스 광고 API 호출
        bool leveledUp = false;
        int? currentLevel;
        
        try {
          final request = BonusAdRequestData(
            receipt: reward.amount.toString(),
            adSessionId: ad.responseInfo?.responseId ?? '',
          );
          
          final response = await ref.read(submitBonusAdProvider((
            stepId: widget.stepId,
            request: request,
          )).future);
          
          leveledUp = response.data.leveledUp;
          currentLevel = response.data.currentLevel;
          
        } catch (e) {
        }

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
        }

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationCompleteScreen(
                method: 'reward_ad',
                content: '광고 신청 완료',
                leveledUp: leveledUp,
                currentLevel: currentLevel,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 닫기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    final authStorage = await AuthStorageService.getInstance();
                    final sideJobId = authStorage.getSideJobId();
                    if (sideJobId != null) {
                      await Future.wait([
                        ref.read(sideJobProgressNotifierProvider.notifier).getSideJobProgress(sideJobId),
                        ref.read(missionListNotifierProvider.notifier).getMissionList('', sideJobId),
                      ]);
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VerificationCompleteScreen(
                          method: 'sub_quest',
                          content: '부퀘스트 완료',
                          leveledUp: widget.leveledUp,
                          currentLevel: widget.currentLevel,
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.close, size: 24, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('경험치 부스트!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF1976D2)),
              textAlign: TextAlign.center),
            const SizedBox(height: 16),
            const Text('추가 경험치를 받을 수 있어요',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF333333)),
              textAlign: TextAlign.center),
            const SizedBox(height: 16),
            const Column(
              children: [
                Text('경험치를 두배 받고',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF666666))),
                SizedBox(height: 4),
                Text('부냥이를 빠르게 성장시키세요',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF666666))),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                // 인증하기
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuestVerificationScreen(
                              stepId: widget.stepId,
                              leveledUp: widget.leveledUp,
                              currentLevel: widget.currentLevel,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '인증하기',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1976D2)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 광고보기
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: _isAdLoading ? const Color(0xFFBDBDBD) : const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: _isAdLoading || _rewardedAd == null
                          ? null
                          : () => _handleRewardAd(),
                      child: Text(
                        _isAdLoading ? '준비 중...' : '보상 받기',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}