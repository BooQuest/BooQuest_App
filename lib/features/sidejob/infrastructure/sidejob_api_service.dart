import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../../../core/network/network_client.dart';
import '../../../features/auth/infrastructure/auth_storage_service.dart';

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
      print('🚀 부업 추천 API 호출 시작...');
      print('📤 요청 데이터: ${requestData.toJson()}');

      // NetworkClient 생성
      final authStorage = await AuthStorageService.getInstance();
      final networkClient = NetworkClient(authStorage);

      // API 호출
      final response = await networkClient.post<Map<String, dynamic>>(
        '/api/onboarding',
        data: requestData.toJson(),
      );

      print('📥 API 응답:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      // 응답 검증
      if (response.statusCode != 200) {
        print('❌ HTTP 상태 코드 오류: ${response.statusCode}');
        return Left(SideJobFailure.serverError('서버 오류 (${response.statusCode})'));
      }

      if (response.data == null) {
        print('❌ 응답 데이터가 null입니다');
        return const Left(SideJobFailure.dataError('응답 데이터가 없습니다'));
      }

      final responseData = response.data!;

      // success 필드 확인
      if (responseData['success'] != true) {
        final message = responseData['message'] as String?;
        print('❌ API 실패 응답: $message');
        return Left(SideJobFailure.serverError(message ?? 'API 요청이 실패했습니다'));
      }

      // data 필드 확인
      if (responseData['data'] == null) {
        print('❌ 추천 데이터가 없습니다');
        return const Left(SideJobFailure.dataError('추천 데이터가 없습니다'));
      }

      // 추천 데이터 파싱
      final recommendationsData = responseData['data'] as List;
      final recommendations = recommendationsData
          .map((item) => _parseSideJobEntity(item))
          .where((entity) => entity != null)
          .cast<SideJobEntity>()
          .toList();

      print('✅ 부업 추천 API 성공: ${recommendations.length}개');

      return Right(recommendations);

    } catch (error, stackTrace) {
      print('❌ 부업 추천 API 호출 중 예외 발생: $error');
      print('Stack trace: $stackTrace');

      // 네트워크 에러 구분
      if (error.toString().contains('SocketException') ||
          error.toString().contains('TimeoutException') ||
          error.toString().contains('HandshakeException')) {
        return Left(SideJobFailure.networkError(error.toString()));
      }

      return Left(SideJobFailure.unknownError(error.toString()));
    }
  }

  /// API 응답에서 SideJobEntity 파싱
  SideJobEntity? _parseSideJobEntity(dynamic item) {
    try {
      if (item is! Map<String, dynamic>) {
        print('⚠️ 잘못된 추천 데이터 형식: $item');
        return null;
      }

      return SideJobEntity(
        id: item['id']?.toString() ?? '',
        title: item['title']?.toString() ?? '',
        description: item['description']?.toString() ?? '',
      );
    } catch (error) {
      print('⚠️ SideJobEntity 파싱 실패: $error, 데이터: $item');
      return null;
    }
  }
}
