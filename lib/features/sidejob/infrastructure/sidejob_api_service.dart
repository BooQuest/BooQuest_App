import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../../../core/network/network_client.dart';
import '../../../features/auth/infrastructure/auth_storage_service.dart';
import '../domain/user_sidejob_entity.dart';

/// 부업 추천 API 호출 서비스
class SideJobApiService {
  static SideJobApiService? _instance;
  static SideJobApiService get instance => _instance ??= SideJobApiService._();
  
  SideJobApiService._();

  /// 부업 추천 API 호출
  /// 
  /// [requestData] 부업 추천 요청 데이터
  /// 
  /// Returns [Either<SideJobFailure, List<SideJobEntity>>]
  Future<Either<SideJobFailure, List<SideJobEntity>>> getSideJobRecommendations(
    SideJobRequestData requestData,
  ) async {
    try {

      // NetworkClient 생성
      final authStorage = await AuthStorageService.getInstance();
      final networkClient = NetworkClient(authStorage);

      // API 호출
      final response = await networkClient.post<Map<String, dynamic>>(
        '/api/onboarding',
        data: requestData.toJson(),
      );

      // 응답 검증
      if (response.statusCode != 200) {
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }

      if (response.data == null) {
        return const Left(SideJobFailure.dataError('응답 데이터가 없습니다'));
      }

      final responseData = response.data!;

      // success 필드 확인
      if (responseData['success'] != true) {
        final message = responseData['message'] as String?;
        return Left(SideJobFailure.serverError(message ?? 'API 요청이 실패했습니다'));
      }

      // data 필드 확인
      if (responseData['data'] == null) {
        return const Left(SideJobFailure.dataError('추천 데이터가 없습니다'));
      }

      // 추천 데이터 파싱
      final recommendationsData = responseData['data'] as List;
      final recommendations = recommendationsData
          .map((item) => _parseSideJobEntity(item))
          .where((entity) => entity != null)
          .cast<SideJobEntity>()
          .toList();

      return Right(recommendations);

    } catch (error, stackTrace) {

      // 네트워크 에러 구분
      if (error.toString().contains('SocketException') ||
          error.toString().contains('TimeoutException') ||
          error.toString().contains('HandshakeException')) {
        return Left(SideJobFailure.networkError(error.toString()));
      }

      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }

  /// 부업 재생성 API 호출
  Future<Either<SideJobFailure, List<SideJobEntity>>> regenerateSideJobs({
    required List<int> sideJobIds,
    required SideJobRequestData generateSideJobRequest,
  }) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final networkClient = NetworkClient(authStorage);

      final response = await networkClient.post<Map<String, dynamic>>(
        '/api/sideJob/regenerate',
        data: {
          'sideJobIds': sideJobIds,
          'generateSideJobRequest': generateSideJobRequest.toJson(),
        },
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(SideJobFailure.serverError(body['message']?.toString() ?? 'API 실패'));
      }

      final list = (body['data'] as List<dynamic>)
          .map((item) => _parseSideJobEntity(item))
          .where((e) => e != null)
          .cast<SideJobEntity>()
          .toList();

      return Right(list);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('SocketException') || msg.contains('TimeoutException')) {
        return Left(SideJobFailure.networkError(msg));
      }
      return Left(SideJobFailure.unknownError(msg));
    }
  }

  /// 단일 부업 재생성 API 호출
  Future<Either<SideJobFailure, SideJobEntity>> regenerateSingleSideJob({
    required int sideJobId,
    required List<String> reasons,
    required String etcFeedback,
    required SideJobRequestData generateSideJobRequest,
  }) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final networkClient = NetworkClient(authStorage);

      final response = await networkClient.post<Map<String, dynamic>>(
        '/api/sideJob/regenerate/$sideJobId',
        data: {
          'feedbackData': {
            'reasons': reasons,
            'etcFeedback': etcFeedback,
          },
          'generateSideJobRequest': generateSideJobRequest.toJson(),
        },
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }
      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(SideJobFailure.serverError(body['message']?.toString() ?? 'API 실패'));
      }

      final data = body['data'] as Map<String, dynamic>;
      final entity = _parseSideJobEntity(data);
      if (entity == null) {
        return const Left(SideJobFailure.dataError('잘못된 부업 데이터'));
      }
      return Right(entity);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('SocketException') || msg.contains('TimeoutException')) {
        return Left(SideJobFailure.networkError(msg));
      }
      return Left(SideJobFailure.unknownError(msg));
    }
  }

  /// 기존 추천된 부업 목록 조회 API 호출
  ///
  /// GET /api/sideJob/{userId}
  ///
  /// 서버에 저장된 사용자의 가장 최근 추천 부업 리스트를 조회합니다.
  /// 성공 시 List<SideJobEntity> 를 반환합니다.
  Future<Either<SideJobFailure, List<SideJobEntity>>> getExistingSideJobs(int userId) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final networkClient = NetworkClient(authStorage);

      final response = await networkClient.get<Map<String, dynamic>>(
        '/api/sideJob/$userId',
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(SideJobFailure.serverError(body['message']?.toString() ?? 'API 실패'));
      }

      final list = (body['data'] as List<dynamic>)
          .map((item) => _parseSideJobEntity(item))
          .where((e) => e != null)
          .cast<SideJobEntity>()
          .toList();

      return Right(list);
    } catch (e, st) {
      final msg = e.toString();
      if (msg.contains('SocketException') || msg.contains('TimeoutException')) {
        return Left(SideJobFailure.networkError(msg));
      }
      return Left(SideJobFailure.unknownError(msg));
    }
  }

  /// 사용자 부업 선택 API
  /// POST /api/user/sideJob
  Future<Either<SideJobFailure, UserSideJobEntity>> selectUserSideJob(int sideJobId) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      final response = await client.post<Map<String, dynamic>>(
        '/api/user/sideJob',
        data: {
          'sideJobId': sideJobId,
        },
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(SideJobFailure.serverError(body['message']?.toString() ?? 'API 실패'));
      }

      final data = body['data'] as Map<String, dynamic>;
      final userSideJob = UserSideJobEntity.fromJson(data);

      // success: true && result: "created" 확인
      if (!userSideJob.isSuccess) {
        return Left(SideJobFailure.serverError('부업 선택에 실패했습니다'));
      }

      return Right(userSideJob);
      
    } catch (e) {
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(SideJobFailure.networkError(message));
      }
      return Left(SideJobFailure.unknownError(message));
    }
  }

  /// API 응답에서 SideJobEntity 파싱
  SideJobEntity? _parseSideJobEntity(dynamic item) {
    try {
      if (item is! Map<String, dynamic>) {
        return null;
      }

      return SideJobEntity(
        id: item['id']?.toString() ?? '',
        title: item['title']?.toString() ?? '',
        description: item['description']?.toString() ?? '',
      );
    } catch (error) {
      return null;
    }
  }
}
