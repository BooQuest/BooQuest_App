import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';
import 'package:booquest/features/quest/domain/repositories/image_proof_repository.dart';
import 'package:booquest/features/quest/domain/entities/image_proof_entity.dart';
import 'package:booquest/features/quest/infrastructure/api/image_proof_api_service.dart';
import 'dart:io';

/// 이미지 인증 리포지토리 구현체
class ImageProofRepositoryImpl implements ImageProofRepository {
  final ImageProofApiService _apiService;

  ImageProofRepositoryImpl(this._apiService);

  @override
  Future<Either<MissionFailure, ImageProofEntity>> uploadImageProof(
    int stepId,
    File imageFile,
  ) async {
    try {
      print('🚀 ImageProofRepositoryImpl: uploadImageProof 시작 - stepId: $stepId');
      
      final result = await _apiService.uploadImageProof(stepId, imageFile);
      
      print('✅ ImageProofRepositoryImpl: uploadImageProof 성공');
      return Right(result);
    } catch (e) {
      print('❌ ImageProofRepositoryImpl: uploadImageProof 실패 - $e');
      return Left(MissionFailure.serverError(e.toString()));
    }
  }
}
