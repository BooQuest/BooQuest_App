import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';

/// 보너스 인증 Repository 인터페이스
abstract class BonusProofRepository {
  /// 보너스 인증 처리
  /// 
  /// [stepId] 인증할 스텝의 ID
  /// [proofType] 인증 타입 (LINK, TEXT, IMAGE)
  /// [content] 인증 내용
  /// 
  /// 성공 시 BonusProofEntity 반환
  /// 실패 시 MissionFailure 반환
  Future<Either<MissionFailure, BonusProofEntity>> submitProof(
    int stepId,
    ProofType proofType,
    String content,
  );
}
