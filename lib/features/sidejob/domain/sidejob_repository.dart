import 'package:dartz/dartz.dart';
import 'sidejob_entity.dart';
import 'sidejob_failure.dart';

/// 부업 추천 Repository 인터페이스
abstract class SideJobRepository {
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
}
