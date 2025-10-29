import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';
import 'package:booquest/features/quest/domain/repositories/bonus_proof_repository.dart';
import 'package:booquest/features/quest/infrastructure/api/bonus_proof_api_service.dart';

/// 보너스 인증 Repository 구현체
class BonusProofRepositoryImpl implements BonusProofRepository {
  final BonusProofApiService _apiService;

  BonusProofRepositoryImpl(this._apiService);

  @override
  Future<Either<MissionFailure, BonusProofEntity>> submitProof(
    int stepId,
    ProofType proofType,
    String content,
  ) async {
    try {
      final result = await _apiService.submitProof(stepId, proofType, content);
      
      return Right(result);
    } catch (e) {
      print('❌ BonusProofRepository: submitProof 실패 - $e');
      
      if (e is Exception) {
        return Left(MissionFailure.serverError(e.toString()));
      } else {
        return Left(MissionFailure.serverError('알 수 없는 오류가 발생했습니다.'));
      }
    }
  }
}
