import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // DesktopWindow.setWindowTitle('Flutter Demo');
    // DesktopWindow.setWindowMinSize(const Size(400, 300));
    // DesktopWindow.setWindowMaxSize(Size.infinite);
    await DesktopWindow.setWindowSize(Size(550,550));
    await DesktopWindow.setMinWindowSize(Size(500,500));
    await DesktopWindow.setMaxWindowSize(Size(700,700));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiceBook code lock',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
          backgroundColor: Colors.white,
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

