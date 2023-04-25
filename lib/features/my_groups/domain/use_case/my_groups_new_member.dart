import 'package:app/features/my_groups/data/models/create_new_member_response.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/create_new_member_request.dart';

class MyGroupsNewMemberUseCase
    extends UseCase<CreateNewMemberResponse, CreateMyNewMemberRequest> {
  final MyGroupsRepository repository;

  MyGroupsNewMemberUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, CreateNewMemberResponse>> call(
      CreateMyNewMemberRequest param) async {
    return await repository.newMember(param);
  }
}
