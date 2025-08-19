import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../domain/sidejob_repository.dart';

/// 부업 추천 가져오기 UseCase
class GetSideJobRecommendations {
  final SideJobRepository _repository;

  const GetSideJobRecommendations(this._repository);

  /// 부업 추천 실행
  /// 
  /// [strengthType] 사용자가 선택한 자신 있는 방식
  /// 
  /// Returns [Either<SideJobFailure, List<SideJobEntity>>]
  Future<Either<SideJobFailure, List<SideJobEntity>>> call(
    String strengthType,
  ) async {
    try {
      // 1. 사용자 데이터 수집
      final userDataResult = await _repository.collectUserData(strengthType);
      
      return userDataResult.fold(
        // 사용자 데이터 수집 실패
        (failure) => Left(failure),
        // 사용자 데이터 수집 성공 -> 부업 추천 요청
        (requestData) async {
          final recommendationsResult = await _repository.getSideJobRecommendations(requestData);
          
          return recommendationsResult.fold(
            // 부업 추천 요청 실패
            (failure) => Left(failure),
            // 부업 추천 요청 성공
            (recommendations) {
              // 로깅
              print('✅ 부업 추천 성공: ${recommendations.length}개');
              for (int i = 0; i < recommendations.length; i++) {
                final rec = recommendations[i];
                print('  📋 부업 ${i + 1}: ${rec.title}');
              }
              
              return Right(recommendations);
            },
          );
        },
      );
    } catch (error, stackTrace) {
      print('❌ GetSideJobRecommendations 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }
}
