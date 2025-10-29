import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import '../../domain/entities/character_growth_entity.dart';

/// 캐릭터 성장 API 서비스
class CharacterGrowthApiService {
  /// 캐릭터 성장 정보를 가져옵니다
  Future<CharacterGrowthEntity> getCharacterGrowth() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      
      final response = await client.get('/api/character/growth');
      
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return CharacterGrowthEntity.fromJson(data);
      } else {
        throw Exception('Failed to load character growth data');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
