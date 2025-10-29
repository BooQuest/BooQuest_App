import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/quest/domain/entities/image_proof_entity.dart';
import 'dart:io';

/// 이미지 인증 API Service
class ImageProofApiService {
  final NetworkClient _networkClient;

  ImageProofApiService(this._networkClient);

  /// 이미지 인증 업로드
  /// 
  /// [stepId] 인증할 스텝의 ID
  /// [imageFile] 업로드할 이미지 파일
  /// 
  /// 성공 시 ImageProofEntity 반환
  /// 실패 시 Exception 발생
  Future<ImageProofEntity> uploadImageProof(
    int stepId,
    File imageFile,
  ) async {
    try {
      // FormData 생성 - File 객체에서 직접 MultipartFile 생성
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
      });
      
      final response = await _networkClient.dio.post(
        '/api/bonus/$stepId/proof/image',
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        
        // 레벨업 체크 로직 추가
        final leveledUp = data['leveledUp'] ?? false;
        final currentLevel = data['currentLevel'] ?? 0;
        
        // ImageProofEntity에 레벨업 정보 포함
        final entityData = Map<String, dynamic>.from(data);
        entityData['leveledUp'] = leveledUp;
        entityData['currentLevel'] = currentLevel;
        
        return ImageProofEntity.fromJson(entityData);
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API 에러: $e /api/bonus/$stepId/proof/image');
      rethrow;
    }
  }
}
