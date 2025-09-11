import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/presentation/screens/quest_verification_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 경험치 부스트 팝업 위젯 (광고 포함)
class ExperienceBoostPopup extends ConsumerStatefulWidget {
  final int stepId;

  const ExperienceBoostPopup({super.key, required this.stepId});

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
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', 
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoading = false;
          });
        },
        onAdFailedToLoad: (error) {
          print('❌ 리워드 광고 로드 실패: $error');
          setState(() {
            _rewardedAd = null;
            _isAdLoading = false;
          });
        },
      ),
    );
  }

  Future<void> _handleRewardAd() async {
    if (_rewardedAd == null) return;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewardedAd(); // 광고 재로딩
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        print('❌ 광고 표시 실패: $error');
        _loadRewardedAd();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) async {
        print('✅ 광고 시청 완료, 보상 지급 처리');

        Navigator.of(context).pop(); // 팝업 닫기

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
          print('❌ 광고 후 API 실패: $e');
        }

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VerificationCompleteScreen(
                method: 'reward_ad',
                content: '보상형 광고 완료',
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
                        builder: (context) => const VerificationCompleteScreen(
                          method: 'sub_quest',
                          content: '부퀘스트 완료',
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
            const Text('보너스 찬스를 놓치지 마세요',
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
                            builder: (context) => QuestVerificationScreen(stepId: widget.stepId),
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
                        _isAdLoading ? '광고 로딩 중...' : '광고보기',
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