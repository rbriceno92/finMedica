import 'package:app/features/profile/domain/repositories/user_info_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/model_user.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:dartz/dartz.dart';

class UserInfoRepositoryImpl extends UserInfoRepository {
  final UserPreferenceDao dao;

  UserInfoRepositoryImpl({required this.dao});

  @override
  Future<Either<ErrorGeneral, ModelUser>> getUserInfo() async {
    return await dao.getUser();
  }
}
