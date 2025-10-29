import 'package:dartz/dartz.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/api/mission_list_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 미션 목록 Repository 구현체
class MissionListRepositoryImpl {

  /// 미션 목록 조회
  /// 
  /// [status]: 미션 상태 ('IN_PROGRESS', 'PLANNED' 등)
  /// [sideJobId]: 사이드잡 ID
  /// 
  /// Returns: 성공 시 MissionListEntity, 실패 시 MainFailure
  Future<Either<MainFailure, MissionListEntity>> getMissionList(String status, int sideJobId) async {
    try {
      
      // Create AuthStorageService and NetworkClient asynchronously within the method
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = MissionListApiService(client); // Local instance

      final response = await apiService.getMissionList(status, sideJobId); // Use local instance

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        
        final missionList = MissionListEntity.fromJson(data);

        return Right(missionList);
      } else {
        print('❌ MissionListRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ MissionListRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
