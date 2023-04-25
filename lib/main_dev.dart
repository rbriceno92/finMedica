import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'core/builds/build_environment.dart';
import 'core/di/modules.dart' as di;

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
          '${record.level.name} ${record.loggerName} ${record.time}: ${record.message}');
    }
  });

  ConfigurationBuild.develop();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  listenDynamicLink();
  runApp(const App());
}

Future<void> listenDynamicLink() async {
  try {
    await Future.delayed(Duration(seconds: 5));
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData);
    }).onError((e) {
      return;
    });
  } catch (_) {
    return;
  }
}

void handleDynamicLink(PendingDynamicLinkData data) {
  try {
    final deepLink = data?.link;
    if (deepLink != null) {
      final isRefer = deepLink.pathSegments.contains('group');
      if (isRefer) {
        final code = deepLink.queryParameters['member_id'];
        if (code != null) {
          print('CODE: $code');
        }
      }
    }
  } catch (e) {
    return;
  }
}
