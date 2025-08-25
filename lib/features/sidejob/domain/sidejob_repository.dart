import 'package:dartz/dartz.dart';
import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';
import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/domain/user_sidejob_entity.dart';

/// 부업 추천 Repository 인터페이스
abstract class SideJobRepository {
  /// 사용자 부업 선택 API
  Future<Either<SideJobFailure, UserSideJobEntity>> selectUserSideJob(int sideJobId);
  
  /// 부업 추천 요청
  /// 
  /// [requestData] 부업 추천 요청 데이터
  /// 
  /// Returns [Either<SideJobFailure, List<SideJobEntity>>]
  /// - Left: 실패 시 SideJobFailure
  /// - Right: 성공 시 부업 추천 리스트
  Future<Either<SideJobFailure, List<SideJobEntity>>> getSideJobRecommendations(
    SideJobRequestData requestData,
  );

  /// 사용자 데이터 수집
  /// 
  /// Returns [Either<SideJobFailure, SideJobRequestData>]
  /// - Left: 실패 시 SideJobFailure  
  /// - Right: 성공 시 수집된 사용자 데이터
  Future<Either<SideJobFailure, SideJobRequestData>> collectUserData(
    String strengthType,
  );

  /// 부업 재생성 요청
  /// 기존 추천된 부업 ID 리스트와, 재생성에 사용할 사용자 요청 데이터 전달
  Future<Either<SideJobFailure, List<SideJobEntity>>> regenerateSideJobs(
    List<int> sideJobIds,
    SideJobRequestData generateSideJobRequest,
  );

  /// 단일 부업 재생성 요청
  Future<Either<SideJobFailure, SideJobEntity>> regenerateSingleSideJob({
    required int sideJobId,
    required List<String> reasons,
    required String etcFeedback,
    required SideJobRequestData generateSideJobRequest,
  });

  /// 기존 추천 부업 목록 조회
  Future<Either<SideJobFailure, List<SideJobEntity>>> getExistingSideJobs(int userId);
}
