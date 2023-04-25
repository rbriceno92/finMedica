import 'package:app/features/profile/domain/repositories/user_info_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/model_user.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetUserInfo extends UseCase<ModelUser, void> {
  final UserInfoRepository repository;

  GetUserInfo({required this.repository});

  @override
  Future<Either<ErrorGeneral, ModelUser>> call(void param) async {
    return await repository.getUserInfo();
  }
}
