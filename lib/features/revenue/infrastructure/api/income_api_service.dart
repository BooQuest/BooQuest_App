import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 수익 API 서비스
class IncomeApiService {
  final NetworkClient _client;

  IncomeApiService(this._client);

  /// 수익 목록 조회
  Future<Response> getIncomeList(int userSideJobId) async {
    return await _client.get('/api/income?userSideJobId=$userSideJobId');
  }
}
