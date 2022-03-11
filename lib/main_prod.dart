import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';
import 'resources/app_config.dart';
import 'main.dart';
import 'package:flutter/foundation.dart';


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


  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors",
    buildFlavor: "Production",
    child: MyApp(),
  );
  return runApp(configuredApp);
}