import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';
import 'package:booquest/features/quest/domain/entities/image_proof_entity.dart';
import 'dart:io';

/// 이미지 인증 리포지토리 인터페이스
abstract class ImageProofRepository {
  /// 이미지 인증 업로드
  /// 
  /// [stepId] 인증할 스텝의 ID
  /// [imageFile] 업로드할 이미지 파일
  /// 
  /// 성공 시 ImageProofEntity 반환
  /// 실패 시 MissionFailure 반환
  Future<Either<MissionFailure, ImageProofEntity>> uploadImageProof(
    int stepId,
    File imageFile,
  );
}
