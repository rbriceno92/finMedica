import 'package:app/features/my_groups/data/models/my_groups_fetch_data_response.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class MyGroupsListUseCase extends UseCase<MyGroupsFetchDataResponse, String> {
  final MyGroupsRepository repository;

  MyGroupsListUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, MyGroupsFetchDataResponse>> call(
      String param) async {
    return await repository.getMyGroupsMembersList(param);
  }
}
