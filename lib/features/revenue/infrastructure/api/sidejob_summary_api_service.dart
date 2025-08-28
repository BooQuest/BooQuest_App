import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 부업 프로젝트 요약 API 서비스
class SideJobSummaryApiService {
  final NetworkClient _client;

  SideJobSummaryApiService(this._client);

  /// 부업 프로젝트 요약 조회
  Future<Response> getSideJobSummary(int userSideJobId) async {
    return await _client.get('/api/user/sideJob/$userSideJobId/summary');
  }
}


