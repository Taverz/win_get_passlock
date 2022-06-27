



import 'package:flutter/cupertino.dart';

abstract class ChoiseEvent{}
class ChoiseInitEvent extends ChoiseEvent{
  final BuildContext contextW;
  ChoiseInitEvent(this.contextW);
}

class ChoiseHotelEvent extends ChoiseEvent{
  final Map<dynamic, dynamic>? idHotel;
  ChoiseHotelEvent(this.idHotel);
}
class ChoiseBuildingEvent extends ChoiseEvent{
  final Map<dynamic, dynamic>? idBuilding;
  ChoiseBuildingEvent(this.idBuilding);
}
class ChoiseRoomEvent extends ChoiseEvent{
  final Map<dynamic, dynamic>? idRoom;
  ChoiseRoomEvent(this.idRoom);
}





