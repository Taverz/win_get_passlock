


abstract class ChoiseState{}
class ChoiseStateInitState extends ChoiseState{}

class ChoiseStateHotelState extends ChoiseState{
    final String? idHotel;
  ChoiseStateHotelState(this.idHotel);
}
class ChoiseStateBuildingState extends ChoiseState{
   final String? idBuilding;
  ChoiseStateBuildingState(this.idBuilding);
}
class ChoiseStateRoomState extends ChoiseState{
  final String? idRoom;
  ChoiseStateRoomState(this.idRoom);
}

class ResultpassCode extends ChoiseState{
  final List<dynamic> data;
  ResultpassCode(this.data);
}