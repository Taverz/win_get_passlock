import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProviderApp extends ChangeNotifier{

  SharedPreferences? prefs ;

  String? _shelterToken;
  String? get sheltertoken {
    return _shelterToken;
  }

  initData() async{
      prefs =await SharedPreferences.getInstance();
  }

  Future<bool> noNullShelterToken() async{
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
    


    // Map<String, Object> resultData = await prefs.getAll();
    // String? token = resultData["token"].toString();
    // if(token == null || token == ""){
    //   return false;
    // }else{
    //   this._shelterToken = token;
    //   return true;
    // }
  }

  Future<String?> getShelterToken() async{
    if(prefs != null){
      final String? token = prefs!.getString('token');
      if(token == null || token == ""){
        return null;
      }else{
        this._shelterToken = token;
        return token;
      }
    }


    // Map<String, Object> resultData = await prefs.getAll();
    // String? token = resultData["token"].toString();
    // if(token == null || token == ""){
    //   return null;
    // }else{
    //   this._shelterToken = token;
    //   return token;
    // }
  }

  setShelterToken(String token) async{
    if(prefs != null){
      await prefs!.setString('token', 'Start');
      this._shelterToken = token;
    }

    // await prefs.setValue('String', 'token', token);
    // this._shelterToken = token;
  }

}