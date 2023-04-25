import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:app/features/change_password/data/models/change_password_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<ErrorGeneral, ChangePasswordResponse>> updatePassword(
      ChangePasswordRequest request);
}
