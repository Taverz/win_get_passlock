

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import 'choise_event.dart';
import 'choise_state.dart';

class ChooiseBloc  extends Bloc<ChoiseEvent, ChoiseState>{


  ChooiseBloc(ChoiseState initialState) : super(initialState){
    // on<AccomodationChoiceYesEvent>(_mapGetCategoriesEventToState);
    // on<AccomodationChoiceYesEvent>(_mapChoiceYes);

    on<ChoiseInitEvent>(_initEv); 

    on<ChoiseHotelEvent>(_chooiseHotel); //((event, emit) => emit(ChoiseStateHomeState()));
    on<ChoiseBuildingEvent>(_chooiseBuilding); //((event, emit) => emit(ChoiseStateBuildingState()));
    on<ChoiseRoomEvent>(_chooiseRoom); //((event, emit) => emit(ChoiseStateRoomState()));

    // on<BasketErrorEvent>((event, emit) => emit(BasketErrorState(message: (event as BasketErrorEvent).message)));
    // on<BasketConfirmEvent>(_confirmBasket);
  }

  @override
  ChoiseState get initialState => ChoiseStateInitState();

  List<dynamic>? _hotels;
  List<dynamic>? _buildings;
  List<dynamic>? _rooms;

  Map? _hotelChoise;
  Map? _buildingChoise;
  Map? _roomChoise;

  DataProviderApp?  providerData;

  _initEv(ChoiseInitEvent event, Emitter<ChoiseState> emit)async {
    providerData = Provider.of<DataProviderApp>(event.contextW, listen: false);
    if(providerData != null){
      providerData!.startP();
      await _getHome();
    }
  }

  _getHome() async{
    var result =await  providerData!.getHotels();
    _hotels = result;
    //render(_hotelChoise);
    // if(_hotelChoise != null){
    //   _chooiseHotel(ChoiseHotelEvent(_hotelChoise!["id"]), emit );
    // }else{
    //   _hotelChoise = null;
    //   _buildingChoise = null;
    //   _roomChoise = null;
    //   _chooiseHotel(ChoiseHotelEvent(null), emit );
    // }
    ///render
    emit(ChoiseStateInitState());
  }

  _chooiseHotel(ChoiseHotelEvent event, Emitter<ChoiseState> emit) async{
    _hotelChoise = {"id":event.idHotel};
    var result =await  providerData!.getBuilders(id: event.idHotel);
    _buildings = result;
    
    if(_buildingChoise != null){
      ///render
      emit(ChoiseStateHotelState(_hotelChoise!["name"]));  
      _chooiseBuilding(ChoiseBuildingEvent(_buildingChoise!["id"]), emit);
    }else{
      _hotelChoise = null;
      _buildingChoise = null;
      _roomChoise = null;
      _chooiseBuilding(ChoiseBuildingEvent(null), emit);
    }
  }

  _chooiseBuilding(ChoiseBuildingEvent event, Emitter<ChoiseState> emit) async{
    _buildingChoise = {"id":event.idBuilding};
    var result = await  providerData!.getRooms(id: event.idBuilding);
    _rooms = result;
    
    if(_roomChoise != null){
      ///render
      emit(ChoiseStateBuildingState(_buildingChoise!['name']));
      _chooiseRoom(ChoiseRoomEvent(_roomChoise!['id']), emit);
    }
  }

  _chooiseRoom(ChoiseRoomEvent event, Emitter<ChoiseState> emit) async{
    _roomChoise = {"number":event.idRoom};
    if(_roomChoise !=null){
      ///render
      emit(ChoiseStateRoomState(_roomChoise!['number']));
    }
  }

  _getPassCode(ChoiseRoomEvent event, Emitter<ChoiseState> emit)async{
    var result = await  providerData!.getPass(id: _roomChoise!['id']);
    if(result != null){
      ///render
      emit(ResultpassCode(result));  
    }
  }



}