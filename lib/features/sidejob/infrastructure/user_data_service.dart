import 'package:dartz/dartz.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../../../core/utils/user_data_utils.dart';

/// 사용자 데이터 수집 서비스
class UserDataService {
  static UserDataService? _instance;
  static UserDataService get instance => _instance ??= UserDataService._();
  
  UserDataService._();

  /// 부업 추천을 위한 사용자 데이터 수집
  /// 
  /// [strengthType] 사용자가 선택한 자신 있는 방식
  /// 
  /// Returns [Either<SideJobFailure, SideJobRequestData>]
  Future<Either<SideJobFailure, SideJobRequestData>> collectUserData(
    String strengthType,
  ) async {
    try {
      print('🔍 사용자 데이터 수집 시작...');

      // 병렬로 모든 데이터 수집
      final results = await Future.wait([
        UserDataUtils.instance.getUserId(),
        UserDataUtils.instance.getNickname(),
        UserDataUtils.instance.getJob(),
        UserDataUtils.instance.getHobbies(),
        UserDataUtils.instance.getExpressionStyle(),
        UserDataUtils.instance.getCharacterType(),
        UserDataUtils.instance.getCharacterName(),
      ]);

      final userId = results[0] as int?;
      final nickname = results[1] as String?;
      final job = results[2] as String?;
      final hobbies = results[3] as List<String>?;
      final expressionStyle = results[4] as String?;
      final characterType = results[5] as String?;
      final characterName = results[6] as String?;

      // 필수 데이터 검증
      if (userId == null) {
        print('❌ 사용자 ID가 없습니다');
        return const Left(SideJobFailure.userDataError('사용자 ID를 찾을 수 없습니다'));
      }

      if (nickname == null || nickname.isEmpty) {
        print('❌ 사용자 닉네임이 없습니다');
        return const Left(SideJobFailure.userDataError('사용자 닉네임을 찾을 수 없습니다'));
      }

      // SideJobRequestData 생성
      final requestData = SideJobRequestData(
        userId: userId,
        nickname: nickname,
        job: job ?? '',
        hobbies: hobbies ?? [],
        expressionStyle: expressionStyle ?? '',
        strengthType: strengthType,
        characterType: characterType ?? '',
        characterName: characterName ?? '',
      );

      print('✅ 사용자 데이터 수집 완료:');
      print('  - userId: $userId');
      print('  - nickname: $nickname');
      print('  - job: $job');
      print('  - hobbies: $hobbies');
      print('  - expressionStyle: $expressionStyle');
      print('  - strengthType: $strengthType');
      print('  - characterType: $characterType');
      print('  - characterName: $characterName');

      return Right(requestData);

    } catch (error, stackTrace) {
      print('❌ 사용자 데이터 수집 중 예외 발생: $error');
      print('Stack trace: $stackTrace');
      return Left(SideJobFailure.userDataError(error.toString()));
    }
  }
}
