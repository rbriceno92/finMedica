import 'package:flutter/material.dart';

import 'app.dart';
import 'core/builds/build_environment.dart';
import 'core/di/modules.dart' as di;

void main() async {
  ConfigurationBuild.qa();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
