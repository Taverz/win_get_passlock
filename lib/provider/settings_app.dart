import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

class SettingsProviderApp extends ChangeNotifier{

  SharedPreferences? prefs ;
  SharedPreferencesWindows? sharedPreferencesWindows;

  String? _shelterToken;
  String? get sheltertoken {
    return _shelterToken;
  }

  initData() async{
     if (Platform.isWindows ) {
       sharedPreferencesWindows = SharedPreferencesWindows();
     }else
      prefs =await SharedPreferences.getInstance();
  }

  Future<bool> noNullShelterToken() async{
    if (Platform.isWindows) {
      if(sharedPreferencesWindows != null){
        Map<String, Object> resultData = await sharedPreferencesWindows!.getAll();
        String? token = resultData["token"].toString();
        if(token == null || token == ""){
          return false;
        }else{
          this._shelterToken = token;
          return true;
        } 
      }else{
        return false;
      }
     }else
      if(prefs != null){
        final String? token = prefs!.getString('token');
        if(token == null || token == ""){
          return false;
        }else{
          this._shelterToken = token;
          return true;
        }  
      }else{
        return false;
      }
  }

  Future<String?> getShelterToken() async{
    if (Platform.isWindows) {
      if(sharedPreferencesWindows != null){
        Map<String, Object> resultData = await sharedPreferencesWindows!.getAll();
        String? token = resultData["token"].toString();
        if(token == null || token == ""){
          return null;
        }else{
          this._shelterToken = token;
          return token;
        }
      }else{
        return null;
      }
    }else
      if(prefs != null){
      final String? token = prefs!.getString('token');
      if(token == null || token == ""){
        return null;
      }else{
        this._shelterToken = token;
        return token;
      }
    }
  }

  setShelterToken(String token) async{
    if (Platform.isWindows) {
      if(sharedPreferencesWindows != null){
        await sharedPreferencesWindows!.setValue('String', 'token', token);
        this._shelterToken = token;
      }
    }else 
      if(prefs != null){
        await prefs!.setString('token', 'Start');
        this._shelterToken = token;
    }
  }

}