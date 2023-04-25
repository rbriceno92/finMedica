import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/add_member_existent_request.dart';

class MyGroupsAddMemberUseCase extends UseCase<bool, AddMemberExistentRequest> {
  final MyGroupsRepository repository;

  MyGroupsAddMemberUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, bool>> call(
      AddMemberExistentRequest param) async {
    return await repository.addMember(param);
  }
}
