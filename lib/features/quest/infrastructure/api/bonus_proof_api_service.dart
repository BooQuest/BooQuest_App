import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';

/// 보너스 인증 API Service
class BonusProofApiService {
  final NetworkClient _networkClient;

  BonusProofApiService(this._networkClient);

  /// 보너스 인증 처리
  /// 
  /// [stepId] 인증할 스텝의 ID
  /// [proofType] 인증 타입 (LINK, TEXT, IMAGE)
  /// [content] 인증 내용
  /// 
  /// 성공 시 BonusProofEntity 반환
  /// 실패 시 Exception 발생
  Future<BonusProofEntity> submitProof(
    int stepId,
    ProofType proofType,
    String content,
  ) async {
    try {
      print('🌐 API 요청: POST /api/bonus/$stepId/proof');
      print('📋 요청 데이터: proofType=$proofType, content=$content');
      
      final response = await _networkClient.dio.post(
        '/api/bonus/$stepId/proof',
        data: {
          'proofType': proofType.name.toUpperCase(),
          'content': content,
        },
      );

      print('📊 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return BonusProofEntity.fromJson(data);
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API 에러: $e /api/bonus/$stepId/proof');
      rethrow;
    }
  }
}
