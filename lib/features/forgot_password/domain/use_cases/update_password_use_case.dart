import 'package:app/features/forgot_password/data/models/update_password_model.dart';
import 'package:app/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:app/util/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../util/use_case.dart';

class UpdatePasswordUseCase extends UseCase<bool, UpdatePasswordModel> {
  final ForgotPasswordRepository forgotPasswordRepository;

  UpdatePasswordUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<ErrorGeneral, bool>> call(UpdatePasswordModel param) async {
    return await forgotPasswordRepository.resetPassword(param);
  }
}
