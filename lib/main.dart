import 'dart:io';

// import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:provider/provider.dart';

import 'provider/coise_provider.dart';
import 'provider/data_provider.dart';
import 'provider/settings_app.dart';
import 'screen/home_screen.dart';
import 'screen/spash_screen.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   _settingsWindow();
  runApp(const MyApp());
}

_settingsWindow() async{
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // DesktopWindow.setWindowTitle('Flutter Demo');
    // DesktopWindow.setWindowMinSize(const Size(400, 300));
    // DesktopWindow.setWindowMaxSize(Size.infinite);
    await DesktopWindow.setWindowSize(Size(550,550));
    await DesktopWindow.setMinWindowSize(Size(500,500));
    await DesktopWindow.setMaxWindowSize(Size(700,700));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context)=> DataProviderApp()),
       ChangeNotifierProvider(create: (context)=> SettingsProviderApp()),
       ChangeNotifierProvider(create: (context)=>ChoiseProvider())
      ],
      child: MaterialApp(
        title: 'ServiceBook code lock',
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        theme: ThemeData(
            backgroundColor: Colors.white,
          primarySwatch: Colors.green,
        ),
        home: Splash(),
      ),
    );
  }
}

