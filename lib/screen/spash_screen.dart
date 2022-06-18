import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_get_passlock/screen/settings.dart';

import '../provider/data_provider.dart';
import '../provider/settings_app.dart';
import 'home_screen.dart';
import 'wind/create.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool tokenNoNull = true;


  _load(BuildContext context) async{

    SettingsProviderApp  providerSetttings = Provider.of<SettingsProviderApp>(context, listen: false);
    await providerSetttings.initData();
    tokenNoNull = await providerSetttings.noNullShelterToken();
    Timer(
        Duration(seconds: 2),
        () async{
          if(tokenNoNull){
          String? tokenS =await providerSetttings.getShelterToken();
            if(tokenS == null || tokenS == ""){
              Navigator.push(
              context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            }else{
              DataProviderApp  providerSetttings = Provider.of<DataProviderApp>(context, listen: false);
              providerSetttings.init(tokenS);
              providerSetttings.startP();
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));  
            }
            
          }else{
            Navigator.push(
            context, MaterialPageRoute(builder: (_) => SettingsScreen()));
          }
          
        }
    );
  }

  Widget build(BuildContext context) {
    _load(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // butWind(),
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                        radius: 40.0,
                        child: Icon(
                          Icons.check_rounded,
                          color: Color(0xFF18D191),
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Менеджер замков",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //CircularProgressIndicator(backgroundColor: Colors.grey),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(
                      "",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 60.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
