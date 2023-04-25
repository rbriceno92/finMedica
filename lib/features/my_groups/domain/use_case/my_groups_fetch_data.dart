import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/get_my_groups_data_response.dart';

class MyGroupsFetchDataUseCase
    extends UseCase<GetMyGroupsDataResponse, ParametroVacio> {
  final MyGroupsRepository repository;

  MyGroupsFetchDataUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, GetMyGroupsDataResponse>> call(
      ParametroVacio param) async {
    return await repository.getMyGroupData(param);
  }
}
