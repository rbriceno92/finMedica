import 'dart:async';

import 'package:app/features/login/data/models/sign_in_params.dart';
import 'package:app/features/refresh_token/domain/use_case/refresh_use_case.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../../navigation/routes_names.dart';

class ChopperRefreshAutenticator extends Authenticator {
  final RefreshUseCase refreshUseCase;
  final SharedPreferences sharedPreferences;
  final UserPreferenceDao userDao;

  ChopperRefreshAutenticator(
      {required this.refreshUseCase,
      required this.userDao,
      required this.sharedPreferences});

  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamed(signInRoute,
          arguments: SignInParams(
            sessionEnd: true,
          ));
    } else {
      return null;
    }
  }
}
