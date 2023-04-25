import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import 'package:app/util/models/model_user.dart';

abstract class UserInfoRepository {
  Future<Either<ErrorGeneral, ModelUser>> getUserInfo();
}
