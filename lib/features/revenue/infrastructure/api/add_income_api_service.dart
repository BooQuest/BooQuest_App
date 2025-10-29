import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 수익 추가 API 서비스
class AddIncomeApiService {
  final NetworkClient _client;

  AddIncomeApiService(this._client);

  /// 수익 추가
  Future<Response> addIncome({
    required int userSideJobId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    final data = {
      'userSideJobId': userSideJobId,
      'title': title,
      'amount': amount,
      'incomeDate': incomeDate,
      'memo': memo,
    };
    
    return await _client.post('/api/income', data: data);
  }
}
