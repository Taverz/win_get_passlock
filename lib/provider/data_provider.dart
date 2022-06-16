import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../repository/api.dart';
import '../repository/exception.dart';

class DataProviderApp extends ChangeNotifier{

  ApiApp? _api;
  String? _tokenShelter;
  List? _listHotels = List.empty(growable: true);
  List? _listBuilders = List.empty(growable: true);
  List? _listRooms = List.empty(growable: true);
  List? _resultTablePass = List.empty(growable: true);

  init(String tokenS){
    this._tokenShelter = tokenS;
  }
  startP(){
    this._api = ApiApp(_tokenShelter??"");
  }
  closeP(){
    if(_api != null)
      this._api!.disposeAPI();
  }

  Future<List?> getHotels({VoidCallback? errore}) async {
    if(this._api != null){
      try{
        Either result = await this._api!.getHotels();
        if(result.isLeft()){
          this._listHotels = (result as Left).value ; //.toOption().toNullable(); 
        }else if(result.isRight()){
          ServerException resErr = (result.toOption().toNullable() as ServerException);
         if(errore != null){
            errore();
          }
        }
      }catch (e){
        if(errore != null){
          errore();
        }
        print("Errore API");
      }
     return this._listHotels; 
    }else{
      if(errore != null){
        errore();
      }
      return null;
    }
  }
  

  Future<List?> getBuilders({String? id, VoidCallback? errore}) async {
    if(this._api != null){
      try{
        var result = await this._api!.getBuilder(id??'');
        if(result.isLeft()){
          this._listBuilders =  (result as Left).value ; //.toOption().toNullable();
        }else if(result.isRight()){
          ServerException resErr = ((result as Right).toOption().toNullable() as ServerException);
          if(errore != null){
            errore();
          }
        }
      }catch (e){
        if(errore != null){
          errore();
        }
        print("Errore API");
      }
     return this._listBuilders; 
    }else{
      if(errore != null){
        errore();
      }
      return null;
    }
  }

  Future<List?> getRooms({String? id, VoidCallback? errore}) async {
    if(this._api != null){
      try{
        var result = await this._api!.getRooms(id??'');
        if(result.isLeft()){
          this._listRooms =  (result as Left).value ; //.toOption().toNullable();
        }else if(result.isRight()){
          ServerException resErr = ((result as Right).toOption().toNullable() as ServerException);
          if(errore != null){
            errore();
          }
        }
      }catch (e){
        if(errore != null){
          errore();
        }
        print("Errore API");
      }
     return this._listRooms; 
    }else{
      if(errore != null){
        errore();
      }
      return null;
    }
  }


  Future<List?> getPass({String? id, VoidCallback? errore}) async {
    if(this._api != null){
      try{
        var result = await this._api!.getPassCode(id??'');
        if(result.isLeft()){
          this._resultTablePass =  (result as Left).value ; //.toOption().toNullable();
        }else if(result.isRight()){
          ServerException resErr = ((result as Right).toOption().toNullable() as ServerException);
          if(errore != null){
            errore();
          }
        }
      }catch (e){
        if(errore != null){
          errore();
        }
        print("Errore API");
      }
     return this._resultTablePass; 
    }else{
      if(errore != null){
        errore();
      }
      return null;
    }
  }
  

}