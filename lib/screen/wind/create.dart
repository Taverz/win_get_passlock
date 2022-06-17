


import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

createWindowWW() async{
  final window = await DesktopMultiWindow.createWindow(jsonEncode({
      'args1': 'Sub window',
      'args2': 100,
      'args3': true,
      'bussiness': 'bussiness_test',
    }));
    window
      ..setFrame(const Offset(0, 0) & const Size(1280, 720))
      ..center()
      ..setTitle('Another window')
      ..show();
}

Widget butWind(){
  return GestureDetector(
    onTap: (){
      createWindowWW();
    },
    child: Container(
      width: 100,
      height: 50,
      color: Colors.blue[200],
      child: Text("создать окно"),
    ),
  );
}