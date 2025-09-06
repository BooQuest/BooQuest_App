import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/presentation/screens/next_quest_setup_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';

/// 인증 완료 화면 - 축하 메시지와 EXP 획득 정보 표시
class VerificationCompleteScreen extends ConsumerWidget {
  final String method; // 인증 방식 (link, text, photo, main_quest)
  final String content; // 인증 내용
  final int? expReward; // 획득 경험치 (메인 퀘스트 완료 시 사용)

  const VerificationCompleteScreen({
    super.key,
    required this.method,
    required this.content,
    this.expReward,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // 캐릭터 이미지 (배경 + 메인 이미지)
              Stack(
                alignment: Alignment.center,
                children: [
                  // 배경 이미지 (뒤쪽)
                  SvgPicture.asset(
                    'assets/images/characters/completed2.svg',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  // 메인 이미지 (앞쪽)
                  Image.asset(
                    'assets/images/characters/completed.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // 축하 메시지
              Text(
                _getCongratulationMessage(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // 인증 완료 메시지
              Text(
                _getVerificationMessage(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // EXP 획득 정보
              Text(
                _getExpMessage(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              // 확인 버튼
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: _buildConfirmButton(context, ref),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 축하 메시지 반환
  String _getCongratulationMessage() {
    if (method == 'main_quest') {
      return '축하드려요!';
    }
    return '축하드려요!';
  }

  /// 인증 방식에 따른 메시지 반환
  String _getVerificationMessage() {
    switch (method) {
      case 'link':
      case 'text':
      case 'photo':
        return '추가 인증 완료';
      case 'main_quest':
        return '메인 퀘스트 완료';
      case 'sub_quest':
        return '부 퀘스트 완료';
      default:
        return '추가 인증 완료';
    }
  }

  /// EXP 메시지 반환
  String _getExpMessage() {
    if (method == 'main_quest') {
      return '+EXP 50만큼 경험치가 올랐어요';
    } else if (method == 'sub_quest' || method == 'link' || method == 'text' || method == 'photo') {
      return '+EXP 10만큼 경험치가 올랐어요';
    }
    return '';
  }

  /// 확인 버튼
  Widget _buildConfirmButton(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () => _onConfirmPressed(context, ref),
        child: const Text(
          '확인',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  /// 확인 버튼 클릭 처리
  void _onConfirmPressed(BuildContext context, WidgetRef ref) async {
    if (method == 'main_quest') {
      // 메인 퀘스트 완료 시: 다음 퀘스트 설정 화면으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NextQuestSetupScreen(),
        ),
      );
    } else {
      // 다른 인증 완료 시: 데이터 리로드 후 quest screen으로 돌아가기
      try {
        // sideJobId 가져오기
        final authStorage = await AuthStorageService.getInstance();
        final sideJobId = authStorage.getSideJobId();
        
        if (sideJobId != null) {
          // 데이터 리로드
          await Future.wait([
            ref.read(sideJobProgressNotifierProvider.notifier).getSideJobProgress(sideJobId),
            ref.read(missionListNotifierProvider.notifier).getMissionList('', sideJobId),
          ]);
        }
      } catch (e) {
        print('데이터 리로드 중 오류: $e');
      }
      
      // quest screen으로 돌아가기
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
