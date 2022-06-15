import 'package:flutter/cupertino.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

class SettingsProviderApp extends ChangeNotifier{

  final SharedPreferencesWindows prefs = SharedPreferencesWindows();

  String? _shelterToken;
  String? get sheltertoken {
    return _shelterToken;
  }

  Future<bool> noNullShelterToken() async{
    Map<String, Object> resultData = await prefs.getAll();
    String? token = resultData["token"].toString();
    if(token == null || token == ""){
      return false;
    }else{
      this._shelterToken = token;
      return true;
    }
  }

  Future<String?> getShelterToken() async{
    Map<String, Object> resultData = await prefs.getAll();
    String? token = resultData["token"].toString();
    if(token == null || token == ""){
      return null;
    }else{
      this._shelterToken = token;
      return token;
    }
  }

  setShelterToken(String token) async{
    await prefs.setValue('String', 'token', token);
    this._shelterToken = token;
  }

}