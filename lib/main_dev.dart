import 'package:firebase_core/firebase_core.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:system_theme/system_theme.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'resources/app_config.dart';
import 'main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBZ13A_jaEZIItP8ezgFVwrFDmkBJohBbk",
        authDomain: "swastik13-8242d.firebaseapp.com",
        databaseURL: "https://swastik13-8242d.firebaseio.com",
        projectId: "swastik13-8242d",
        storageBucket: "swastik13-8242d.appspot.com",
        messagingSenderId: "536545876267",
        appId: "1:536545876267:web:21154dbdb599a7b9abcd6e",
        measurementId: "G-VP4VMCWCD8"
    )
  );
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentInstance;
  }

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle('hidden');
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(755, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }
  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors Dev",
    buildFlavor: "Development",
    child: const MyApp(),
  );
  return runApp(configuredApp);
}