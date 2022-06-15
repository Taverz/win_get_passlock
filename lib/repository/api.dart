


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:win_get_passlock/repository/exception.dart';

class ApiApp {
  String? _tokenShelter; //iGoha1DmrhX4I6dKTUiuaxC7JuyKmaY3znYzOfGtvQm7A9LBLNta3jVVdf75
  String _url = "https://lock.service-book.io";
  String _urlPostFics = "/api/desk/";

  String _getUrlHotels = "get_hotels";
  String _getUrlBuildings = "get_buildings";
  String _getUrlRooms = "get_rooms";
  String _getUrlPasscode = "get_pass";

  late Dio _dio;
  ApiApp(String token){
    _dio = Dio();
    this._tokenShelter = token;
  }

  disposeAPI(){
    _dio.close(force: true);
  }

  Future<Either<List, ServerException>> getHotels() async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlHotels", 
        data: {'shelter_token': _tokenShelter}
      ); 
      var result =  response.data[""];
      return Left(result);
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlHotels"));
    }
  }
  Future<Either<List, ServerException>> getBuilder(String idHotels) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlBuildings", 
        data: {
          'shelter_token': _tokenShelter
        }
      ); 
      var result =  response.data[""];
      return result;
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlBuildings"));
    }
  }
  Future<Either<List, ServerException>> getRooms(String idbuilders) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlRooms", 
        data: {
          'shelter_token': _tokenShelter
        }
      ); 
      var result =  response.data[""];
      return result;
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlRooms"));
    }
  }

  Future<Either<List, ServerException>> getPassCode(String idRooms) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlPasscode", 
        data: {
          'shelter_token': _tokenShelter, 
          'room_id': idRooms
        }
      ); 
      var result =  response.data[""];
      return result;
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlPasscode"));
    }
  }

}