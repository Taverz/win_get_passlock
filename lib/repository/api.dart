


import 'dart:convert';

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
    _dio.options = BaseOptions(contentType: "application/json");
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
      String data =  response.data["hotels"];
      List<dynamic> result = jsonDecode(data);  
      return Left(result);
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlHotels"));
    }
  }
    //   {
    // 	"hotels": "[
    //     {\"id\":\"1\",\"name\":\"\\ufffd\\ufffd\\ufffd\\ufffd\\ufffd \\\"SHELTER\\\"\"},
    //   {\"id\":\"2\",\"name\":\"MariChalet\"},
    //   {\"id\":\"3\",\"name\":\"K9\"},
    //   {\"id\":\"4\",\"name\":\"K9 Apartment\"},
    //   {\"id\":\"5\",\"name\":\"K9\"}
    //   ]"
    // }



  Future<Either<List, ServerException>> getBuilder(String idHotels) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlBuildings", 
        data: {
          'shelter_token': _tokenShelter
        }
      ); 
      String data =  response.data["buildings"];
      List<dynamic> result = jsonDecode(data);
      return Left(result);
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlBuildings"));
    }
  }
  // {
  //   "buildings": "[
  //     {\"id\":\"1\",\"hotel\":\"2\",\"name\":\"Korpus 1\"},
  //     {\"id\":\"4\",\"hotel\":\"2\",\"name\":\"Korpus 2\"}
  //     ]"
  // }



  Future<Either<List, ServerException>> getRooms(String idbuilders) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlRooms", 
        data: {
          'shelter_token': _tokenShelter
        }
      ); 
      String data =  response.data["rooms"];
      List<dynamic> result = jsonDecode(data);
      return Left(result);
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlRooms"));
    }
  }
  // {
  //   "rooms": "[
  //     {\"id\":\"1\",\"hotel\":\"2\",\"roomkind\":\"7\",\"building\":\"1\",\"floor\":\"1\",\"number\":\"101\"},
  //     {\"id\":\"2\",\"hotel\":\"2\",\"roomkind\":\"7\",\"building\":\"1\",\"floor\":\"1\",\"number\":\"107\"},
  //     {\"id\":\"18\",\"hotel\":\"2\",\"roomkind\":\"6\",\"building\":\"1\",\"floor\":\"3\",\"number\":\"304\"},
  //     {\"id\":\"19\",\"hotel\":\"5\",\"roomkind\":\"8\",\"building\":\"4\",\"floor\":\"1\",\"number\":\"101\"},
  //     {\"id\":\"20\",\"hotel\":\"2\",\"roomkind\":\"8\",\"building\":\"4\",\"floor\":\"1\",\"number\":\"11\"}
  //     ]"
  // }

  Future<Either<List, ServerException>> getPassCode(String idRooms) async{
    try{
      Response response =await _dio.post(
        "$_url$_urlPostFics$_getUrlPasscode", 
        data: {
          'shelter_token': _tokenShelter, 
          'room_id': idRooms
        }
      ); 
      var data33 = response.data;
      String data1 =  response.data.toString();
      // String data = data1.split(' ').toString();
      List<dynamic> result = [];
      result.add(data33);
      return Left(result);
    }catch(e){
      return Right(ServerException(exception: e.toString(), url: "$_url$_urlPostFics$_getUrlPasscode"));
    }
  }

// {id: 66, name: 123, code: 0707125, code_id: 171531036, phone: 89525612028, 
//who_issued: test, period_from: 2022-06-17 08:08:59, period_to: 2022-06-18 09:00:00, 
//factual_date: 2022-06-17 08:08:59, room_id: 4, hotel_id: 2, status: 1, created_at: 2022-06-17T08:10:33.000000Z,
// updated_at: 2022-06-17T08:10:33.000000Z, uun: null}

}