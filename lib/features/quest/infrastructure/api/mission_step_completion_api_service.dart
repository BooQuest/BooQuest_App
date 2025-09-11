import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/quest/domain/entities/mission_step_completion_entity.dart';

/// 퀘스트 스텝 완료 API Service
class MissionStepCompletionApiService {
  final NetworkClient _networkClient;

  MissionStepCompletionApiService(this._networkClient);

  /// 퀘스트 스텝 완료 처리
  /// 
  /// [stepId] 완료할 스텝의 ID
  /// [status] 변경할 상태 (보통 "COMPLETED")
  /// 
  /// 성공 시 MissionStepCompletionEntity 반환
  /// 실패 시 Exception 발생
  Future<MissionStepCompletionEntity> completeStep(
    int stepId,
    String status,
  ) async {
    try {
      final response = await _networkClient.dio.patch(
        '/api/missions/steps/$stepId/status',
        data: {
          'status': status,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        
        // null 값 처리
        final sanitizedData = _sanitizeResponseData(data);
        
        // 레벨업 체크 로직 추가
        final leveledUp = data['leveledUp'] ?? false;
        final currentLevel = data['currentLevel'] ?? 0;
        
        // MissionStepCompletionEntity에 레벨업 정보 포함
        sanitizedData['leveledUp'] = leveledUp;
        sanitizedData['currentLevel'] = currentLevel;
        
        return MissionStepCompletionEntity.fromJson(sanitizedData);
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 응답 데이터의 null 값을 기본값으로 변환
  Map<String, dynamic> _sanitizeResponseData(Map<String, dynamic> data) {
    final sanitized = Map<String, dynamic>.from(data);
    
    // step 데이터 정리
    if (sanitized['step'] != null) {
      final step = Map<String, dynamic>.from(sanitized['step']);
      step['id'] = step['id'] ?? 0;
      step['seq'] = step['seq'] ?? 0;
      step['title'] = step['title'] ?? '';
      step['status'] = step['status'] ?? '';
      step['detail'] = step['detail'] ?? '';
      sanitized['step'] = step;
    }
    
    // character 데이터 정리
    if (sanitized['character'] != null) {
      final character = Map<String, dynamic>.from(sanitized['character']);
      character['userId'] = character['userId'] ?? 0;
      character['name'] = character['name'] ?? '';
      character['level'] = character['level'] ?? 0;
      character['exp'] = character['exp'] ?? 0;
      character['characterType'] = character['characterType'] ?? '';
      character['avatarUrl'] = character['avatarUrl'] ?? '';
      sanitized['character'] = character;
    }
    
    // expDelta 정리
    sanitized['expDelta'] = sanitized['expDelta'] ?? 0;
    
    return sanitized;
  }
}
