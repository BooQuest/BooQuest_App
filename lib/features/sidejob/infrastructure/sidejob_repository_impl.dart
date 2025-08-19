import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../domain/sidejob_repository.dart';
import 'sidejob_api_service.dart';
import 'user_data_service.dart';

/// 부업 추천 Repository 구현체
class SideJobRepositoryImpl implements SideJobRepository {
  final SideJobApiService _apiService;
  final UserDataService _userDataService;

  SideJobRepositoryImpl({
    SideJobApiService? apiService,
    UserDataService? userDataService,
  }) : _apiService = apiService ?? SideJobApiService.instance,
        _userDataService = userDataService ?? UserDataService.instance;

  @override
  Future<Either<SideJobFailure, List<SideJobEntity>>> getSideJobRecommendations(
    SideJobRequestData requestData,
  ) async {
    try {
      print('🔄 Repository: 부업 추천 요청 처리 중...');
      
      // API 서비스 호출
      final result = await _apiService.getSideJobRecommendations(requestData);
      
      return result.fold(
        (failure) {
          print('❌ Repository: API 서비스 실패 - ${failure.debugMessage}');
          return Left(failure);
        },
        (recommendations) {
          print('✅ Repository: API 서비스 성공 - ${recommendations.length}개');
          return Right(recommendations);
        },
      );
    } catch (error, stackTrace) {
      print('❌ Repository: getSideJobRecommendations 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }

  @override
  Future<Either<SideJobFailure, SideJobRequestData>> collectUserData(
    String strengthType,
  ) async {
    try {
      print('🔄 Repository: 사용자 데이터 수집 중...');
      
      // 사용자 데이터 서비스 호출
      final result = await _userDataService.collectUserData(strengthType);
      
      return result.fold(
        (failure) {
          print('❌ Repository: 사용자 데이터 수집 실패 - ${failure.debugMessage}');
          return Left(failure);
        },
        (requestData) {
          print('✅ Repository: 사용자 데이터 수집 성공');
          return Right(requestData);
        },
      );
    } catch (error, stackTrace) {
      print('❌ Repository: collectUserData 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }
}
