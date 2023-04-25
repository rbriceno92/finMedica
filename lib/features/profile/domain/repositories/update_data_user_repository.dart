import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../data/models/update_data_user_model.dart';
import '../../data/models/update_data_user_response.dart';

abstract class UpdateDataUserRepository {
  Future<Either<ErrorGeneral, UpdateDataUserResponse>> upDateData(
      UpdateDataUserModel updateData);
}
