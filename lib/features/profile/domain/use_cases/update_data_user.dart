import 'package:app/features/profile/data/models/update_data_user_model.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/update_data_user_response.dart';
import '../entities/update_data.dart';
import '../repositories/update_data_user_repository.dart';

class UpdateDataUser extends UseCase<UpdateDataUserResponse, UpdateData> {
  final UpdateDataUserRepository signInRepository;

  UpdateDataUser({required this.signInRepository});
  @override
  Future<Either<ErrorGeneral, UpdateDataUserResponse>> call(
      UpdateData param) async {
    return await signInRepository
        .upDateData(UpdateDataUserModel(phone: param.phone));
  }
}
