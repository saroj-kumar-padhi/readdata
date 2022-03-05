import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';
import 'resources/app_config.dart';
import 'main.dart';
import 'package:flutter/foundation.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentInstance;
  }


  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors",
    buildFlavor: "Production",
    child: MyApp(),
  );
  return runApp(configuredApp);
}