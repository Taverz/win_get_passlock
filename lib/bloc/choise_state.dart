


abstract class ChoiseState{}
class ChoiseStateInitState extends ChoiseState{}
class ChoiseStateInitState2 extends ChoiseState{
  List<dynamic>? listRes;
  final  Map<dynamic, dynamic>? idHotel;
  ChoiseStateInitState2(this.listRes, this.idHotel);
}

class ChoiseStateHotelState extends ChoiseState{
  final Map<dynamic, dynamic>? idHotel;
  List<dynamic>? listRes;
  ChoiseStateHotelState(this.idHotel, this.listRes);
}
class ChoiseStateBuildingState extends ChoiseState{
  final  Map<dynamic, dynamic>? idBuilding;
  List<dynamic>? listRes;
  ChoiseStateBuildingState(this.idBuilding, this.listRes);
}
class ChoiseStateRoomState extends ChoiseState{
  final  Map<dynamic, dynamic>? idRoom;
  ChoiseStateRoomState(this.idRoom);
}

class ResultpassCode extends ChoiseState{
  final List<dynamic> data;
  ResultpassCode(this.data);
}