import 'package:dartz/dartz.dart';
import 'package:booquest/features/main/domain/entities/user_sidejob_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/api/user_sidejob_list_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 사용자 사이드잡 목록 Repository 구현체
class UserSideJobListRepositoryImpl {
  /// 사용자 사이드잡 목록 조회
  Future<Either<MainFailure, UserSideJobListEntity>> getUserSideJobList() async {
    try {
      // Create AuthStorageService and NetworkClient asynchronously within the method
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = UserSideJobListApiService(client);

      final response = await apiService.getUserSideJobList();

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as List<dynamic>;
        final sideJobList = UserSideJobListEntity(
          sideJobs: data.map((json) => UserSideJobEntity.fromJson(json)).toList(),
        );

        return Right(sideJobList);
      } else {
        print('❌ UserSideJobListRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ UserSideJobListRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
