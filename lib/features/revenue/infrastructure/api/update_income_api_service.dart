import 'package:booquest/core/network/network_client.dart';

/// 수익 수정 API 서비스
class UpdateIncomeApiService {
  final NetworkClient _client;

  UpdateIncomeApiService(this._client);

  /// 수익 수정 API 호출
  Future<Map<String, dynamic>> updateIncome({
    required int incomeId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    try {
      final response = await _client.put('/api/income/$incomeId', data: {
        'title': title,
        'amount': amount,
        'incomeDate': incomeDate,
        'memo': memo,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
