import 'dart:convert';

import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/model_user.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferenceDao {
  final SharedPreferences sharedPreferences;
  UserPreferenceDao({required this.sharedPreferences});

  Future<Either<ErrorGeneral, ModelUser>> getUser() {
    final jsonString = sharedPreferences.getString('user');
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        return Future.value(Right(ModelUser.fromJson(json.decode(jsonString))));
      } catch (ex) {
        sharedPreferences.remove('user');
        return Future.value(const Left(ErrorMessage(message: ERROR_MESSAGE)));
      }
    } else {
      return Future.value(const Left(ErrorMessage(message: USER_NOT_FOUND)));
    }
  }

  Future<void> saveUser(ModelUser user) {
    return sharedPreferences.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> deleteUser() {
    return sharedPreferences.remove('user');
  }
}
