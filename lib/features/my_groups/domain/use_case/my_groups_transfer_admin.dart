import 'package:app/features/my_groups/data/models/edit_admin_request.dart';
import 'package:app/features/my_groups/data/models/edit_admin_response.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class MyGroupsEditAdminUseCase
    extends UseCase<AdminEditResponse, EditAdminRequest> {
  final MyGroupsRepository repository;

  MyGroupsEditAdminUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, AdminEditResponse>> call(
      EditAdminRequest param) async {
    return await repository.transferManagement(param);
  }
}
