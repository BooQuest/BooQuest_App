import 'package:dartz/dartz.dart';
import '../../domain/entities/character_growth_entity.dart';
import '../../domain/failures/main_failure.dart';
import '../api/character_growth_api_service.dart';

/// 캐릭터 성장 리포지토리 구현체
class CharacterGrowthRepositoryImpl {
  /// 캐릭터 성장 정보를 가져옵니다
  Future<Either<MainFailure, CharacterGrowthEntity>> getCharacterGrowth() async {
    try {
      final apiService = CharacterGrowthApiService();
      final data = await apiService.getCharacterGrowth();
      print('Repository: Successfully got character growth data'); // 디버깅용 print
      return Right(data);
    } catch (e) {
      print('Repository Error: $e'); // 디버깅용 print
      if (e.toString().contains('Network error')) {
        return const Left(MainFailure.networkError());
      } else if (e.toString().contains('401')) {
        return const Left(MainFailure.unauthorized());
      } else if (e.toString().contains('404')) {
        return const Left(MainFailure.notFound());
      } else {
        return const Left(MainFailure.serverError());
      }
    }
  }
}
