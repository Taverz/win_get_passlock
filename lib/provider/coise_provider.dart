

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_provider.dart';

class ChoiseProvider extends ChangeNotifier {



  List<dynamic>? hotels;
  List<dynamic>? buildings;
  List<dynamic>? rooms;

  Map? hotelChoise;
  Map? buildingChoise;
  Map? roomChoise;

  List<dynamic>? resultReq;

  DataProviderApp?  providerData;

  initEv(BuildContext contextW,  Function finiish)async {
    providerData = Provider.of<DataProviderApp>(contextW, listen: false);
    if(providerData != null){
      providerData!.startP();
      await getHome();
      finiish();
    }
  }

  getHome() async{
    var result =await  providerData!.getHotels();
    hotels = result;
    //render(hotelChoise);
    // if(hotelChoise != null){
    //   chooiseHotel(ChoiseHotelEvent(hotelChoise!["id"]), emit );
    // }else{
    //   hotelChoise = null;
    //   buildingChoise = null;
    //   roomChoise = null;
    //   chooiseHotel(ChoiseHotelEvent(null), emit );
    // }
    ///render
    // emit(hotels, null);
     notifyListeners();
  }

  chooiseHotel(Map?  event, Function finiish) async{
    hotelChoise = event;
    var result =await  providerData!.getBuilders(id: event!["id"]);
    buildings = result;
    notifyListeners();
    finiish();
    if(buildingChoise != null){
      ///render
      // emit(hotels, hotelChoise);
      // emit(hotelChoise, buildings);  
      chooiseBuilding(buildingChoise, (){});
    }else{
      // hotelChoise = null;
      buildingChoise = null;
      roomChoise = null;
      // emit(hotels, hotelChoise);
      // emit(hotelChoise, buildings);  
      // chooiseBuilding(null);
    }
  }

  chooiseBuilding(Map?  event,Function finiish) async{
    buildingChoise = event;
    var result = await  providerData!.getRooms(id: event!["id"]);
    rooms = result;
    notifyListeners();
    finiish();
    if(roomChoise != null){
      ///render
      // emit(buildingChoise, rooms);
      chooiseRoom(roomChoise,(){});
    }
  }

  chooiseRoom(Map?  event,Function finiish) async{
    roomChoise = event;
    if(roomChoise !=null){
      ///render
      // emit(roomChoise);
    }
     notifyListeners();
     finiish();
  }

  getPassCode(Function finiish) async{
    var result = await  providerData!.getPass(id: roomChoise!['id']);
    if(result != null){
      resultReq = result;
      ///render
      // emit(result);  
    }
     notifyListeners();
     finiish();
  }


}