import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../domain/sidejob_repository.dart';
import '../domain/user_sidejob_entity.dart';
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
      
      // API 서비스 호출
      final result = await _apiService.getSideJobRecommendations(requestData);
      
      return result.fold(
        (failure) {
          return Left(failure);
        },
        (recommendations) {
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
      
      // 사용자 데이터 서비스 호출
      final result = await _userDataService.collectUserData(strengthType);
      
      return result.fold(
        (failure) {
          print('❌ Repository: 사용자 데이터 수집 실패 - ${failure.debugMessage}');
          return Left(failure);
        },
        (requestData) {
          return Right(requestData);
        },
      );
    } catch (error, stackTrace) {
      print('❌ Repository: collectUserData 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }

  @override
  Future<Either<SideJobFailure, List<SideJobEntity>>> regenerateSideJobs(
    List<int> sideJobIds,
    SideJobRequestData generateSideJobRequest,
  ) async {
    try {
      print('🔄 Repository: 부업 재생성 요청 처리 중...');
      final result = await _apiService.regenerateSideJobs(
        sideJobIds: sideJobIds,
        generateSideJobRequest: generateSideJobRequest,
      );
      return result;
    } catch (e, st) {
      print('❌ Repository: regenerateSideJobs 예외 발생: $e');
      print(st);
      return Left(SideJobFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<SideJobFailure, SideJobEntity>> regenerateSingleSideJob({
    required int sideJobId,
    required List<String> reasons,
    required String etcFeedback,
    required SideJobRequestData generateSideJobRequest,
  }) async {
    try {
      print('🔄 Repository: 단일 부업 재생성 요청 처리 중...');
      final result = await _apiService.regenerateSingleSideJob(
        sideJobId: sideJobId,
        reasons: reasons,
        etcFeedback: etcFeedback,
        generateSideJobRequest: generateSideJobRequest,
      );
      return result;
    } catch (e, st) {
      print('❌ Repository: regenerateSingleSideJob 예외 발생: $e');
      print(st);
      return Left(SideJobFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<SideJobFailure, UserSideJobEntity>> selectUserSideJob(int sideJobId) {
    return _apiService.selectUserSideJob(sideJobId);
  }

  @override
  /// 기존 추천된 부업 목록 조회
  ///
  /// GET /api/sideJob/{userId}
  /// 성공 시 서버에 저장된 최근 추천 목록을 반환
  Future<Either<SideJobFailure, List<SideJobEntity>>> getExistingSideJobs(int userId) async {
    try {
      final result = await _apiService.getExistingSideJobs(userId);
      return result.fold(
        (failure) {
          return Left(failure);
        },
        (entities) {
          return Right(entities);
        },
      );
    } catch (error, stackTrace) {
      print('❌ Repository: getExistingSideJobs 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }
}
