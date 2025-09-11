import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/application/states/image_proof_state.dart';
import 'package:booquest/features/quest/domain/repositories/image_proof_repository.dart';
import 'package:booquest/features/quest/domain/entities/image_proof_entity.dart';
import 'dart:io';

/// 이미지 인증 Notifier
class ImageProofNotifier extends StateNotifier<ImageProofState> {
  final ImageProofRepository _repository;

  ImageProofNotifier(this._repository) : super(const ImageProofState.initial());

  /// 이미지 인증 업로드
  Future<void> uploadImageProof(int stepId, File imageFile) async {
    try {
      print('🚀 ImageProofNotifier: uploadImageProof 시작 - stepId: $stepId, imageFile: ${imageFile.path}');
      
      state = const ImageProofState.loading();

      final result = await _repository.uploadImageProof(stepId, imageFile);

      result.fold(
        (failure) {
          final message = failure.when(
            serverError: (msg) => msg,
            networkError: (msg) => msg,
            authError: (msg) => msg,
            unknownError: (msg) => msg,
          );
          print('❌ ImageProofNotifier: uploadImageProof 실패 - $message');
          state = ImageProofState.failure(message);
        },
        (data) {
          print('✅ ImageProofNotifier: uploadImageProof 성공 - status: ${data.status}, additionalExp: ${data.additionalExp}');
          
          // 레벨업 체크
          if (data.leveledUp) {
            print('🎉 레벨업 발생! 현재 레벨: ${data.currentLevel}');
            state = ImageProofState.levelUp(data);
          } else {
            state = ImageProofState.success(data);
          }
        },
      );
    } catch (e) {
      print('❌ ImageProofNotifier: uploadImageProof 예외 발생 - $e');
      state = ImageProofState.failure('알 수 없는 오류가 발생했습니다.');
    }
  }

  /// 상태 초기화
  void reset() {
    state = const ImageProofState.initial();
  }
}
