import 'package:app/core/builds/build_environment.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/app_routes.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/modules.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final log = Logger('app.dart');

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log.info('test log');
    var prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    return MaterialApp(
      title: 'FinMedica',
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        Languages.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
      onGenerateRoute: generateRoute,
      initialRoute: (token?.isEmpty ?? true) ? splashRoute : dashboardRoute,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: ConfigurationBuild.isDevelop(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
