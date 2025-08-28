import 'package:booquest/core/network/network_client.dart';

/// 수익 삭제 API 서비스
class DeleteIncomeApiService {
  final NetworkClient _client;

  DeleteIncomeApiService(this._client);

  /// 수익 삭제 API 호출
  Future<Map<String, dynamic>> deleteIncome(int incomeId) async {
    try {
      final response = await _client.delete('/api/income/$incomeId');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
