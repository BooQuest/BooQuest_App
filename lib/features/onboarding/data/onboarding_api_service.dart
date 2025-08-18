import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 온보딩 API 서비스
class OnboardingApiService {
  final NetworkClient _networkClient;

  OnboardingApiService(this._networkClient);

  /// 온보딩 데이터 제출
  Future<Response<Map<String, dynamic>>> submitOnboarding(Map<String, dynamic> request) async {
    return await _networkClient.post<Map<String, dynamic>>(
      '/api/onboarding',
      data: request,
    );
  }

  /// 온보딩 진행 상태 조회
  Future<Response<Map<String, dynamic>>> getOnboardingProgress(int userId) async {
    return await _networkClient.get<Map<String, dynamic>>(
      '/api/onboarding/progress/$userId',
    );
  }

  /// 온보딩 데이터 저장
  Future<Response<Map<String, dynamic>>> saveOnboardingData(Map<String, dynamic> data) async {
    return await _networkClient.post<Map<String, dynamic>>(
      '/api/onboarding/save',
      data: data,
    );
  }
}
