



import 'package:flutter/cupertino.dart';

abstract class ChoiseEvent{}
class ChoiseInitEvent extends ChoiseEvent{
  final BuildContext contextW;
  ChoiseInitEvent(this.contextW);
}

class ChoiseHotelEvent extends ChoiseEvent{
  final String? idHotel;
  ChoiseHotelEvent(this.idHotel);
}
class ChoiseBuildingEvent extends ChoiseEvent{
  final String? idBuilding;
  ChoiseBuildingEvent(this.idBuilding);
}
class ChoiseRoomEvent extends ChoiseEvent{
   final String? idRoom;
  ChoiseRoomEvent(this.idRoom);
}





