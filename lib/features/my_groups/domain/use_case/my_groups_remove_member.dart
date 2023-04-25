import 'package:app/features/my_groups/data/models/remove_member_response.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/remove_member_request.dart';

class MyGroupsRemoveMemberUseCase
    extends UseCase<RemoveMemberResponse, RemoveMemberRequest> {
  final MyGroupsRepository repository;

  MyGroupsRemoveMemberUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, RemoveMemberResponse>> call(
      RemoveMemberRequest param) async {
    return await repository.removeMember(param);
  }
}
