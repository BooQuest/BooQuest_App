import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/domain/sidejob_repository.dart';
import 'package:booquest/features/sidejob/domain/user_sidejob_entity.dart';
import 'package:dartz/dartz.dart';

/// 사용자 부업 선택 Use Case
class SelectUserSideJob {
  final SideJobRepository _repository;

  const SelectUserSideJob(this._repository);

  /// 사용자 부업 선택 실행
  Future<Either<SideJobFailure, UserSideJobEntity>> call(int sideJobId) async {
    return await _repository.selectUserSideJob(sideJobId);
  }
}
