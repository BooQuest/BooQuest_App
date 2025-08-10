import 'package:dio/dio.dart';
import 'package:booquest/features/auth/domain/auth_repository.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/core/constants.dart';

/// AuthRepository 인터페이스의 실제 구현체
/// 
/// Spring API와의 통신을 통해 인증 기능을 구현합니다.
/// 현재는 Spring API가 구현되지 않아 임시로 성공 응답만 반환합니다.
class AuthRepositoryImpl implements AuthRepository {
  final NetworkClient _networkClient;
  
  AuthRepositoryImpl(this._networkClient);
  
  @override
  Future<Result<UserInfo>> loginWithSocial({
    required String accessToken,
    required String provider,
  }) async {
    try {
      // TODO: Spring API가 구현되면 실제 API 호출로 교체
      // final response = await _networkClient.post<Map<String, dynamic>>(
      //   AppConstants.loginEndpoint,
      //   data: LoginRequest(
      //     provider: provider,
      //     accessToken: accessToken,
      //   ).toJson(),
      // );
      // 
      // final loginResponse = LoginResponse.fromJson(response.data!);
      // return Success(loginResponse.userInfo);
      
      // 임시 구현: 성공 응답 반환
      await Future.delayed(const Duration(seconds: 1)); // API 호출 시뮬레이션
      
      final userInfo = UserInfo(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        email: 'user@example.com',
        name: '테스트 사용자',
        profileImage: null,
        provider: provider,
      );
      
      return Success(userInfo);
      
    } on DioException catch (e) {
      final errorMessage = _networkClient.handleError(e);
      return Failure(errorMessage, e);
    } catch (e) {
      return Failure(AppConstants.unknownErrorMessage, e);
    }
  }
  
  @override
  Future<Result<void>> logout() async {
    try {
      // TODO: Spring API가 구현되면 실제 로그아웃 API 호출
      // await _networkClient.post('/api/auth/logout');
      
      // 임시 구현: 성공 응답 반환
      await Future.delayed(const Duration(milliseconds: 500));
      
      return const Success(null);
      
    } on DioException catch (e) {
      final errorMessage = _networkClient.handleError(e);
      return Failure(errorMessage, e);
    } catch (e) {
      return Failure(AppConstants.unknownErrorMessage, e);
    }
  }
  
  @override
  Future<Result<UserInfo?>> getCurrentUser() async {
    try {
      // TODO: Spring API가 구현되면 실제 사용자 정보 조회 API 호출
      // final response = await _networkClient.get<Map<String, dynamic>>('/api/auth/me');
      // 
      // if (response.data != null) {
      //   final userInfo = UserInfo.fromJson(response.data!);
      //   return Success(userInfo);
      // }
      // 
      // return const Success(null);
      
      // 임시 구현: 로그인된 사용자가 없다고 가정
      await Future.delayed(const Duration(milliseconds: 300));
      
      return const Success(null);
      
    } on DioException catch (e) {
      final errorMessage = _networkClient.handleError(e);
      return Failure(errorMessage, e);
    } catch (e) {
      return Failure(AppConstants.unknownErrorMessage, e);
    }
  }
} 