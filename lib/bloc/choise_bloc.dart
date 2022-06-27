

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import 'choise_event.dart';
import 'choise_state.dart';

class ChooiseBloc  extends Bloc<ChoiseEvent, ChoiseState>{


  ChooiseBloc(ChoiseState initialState) : super(initialState){
    // on<AccomodationChoiceYesEvent>(_mapGetCategoriesEventToState);
    // on<AccomodationChoiceYesEvent>(_mapChoiceYes);

    on<ChoiseInitEvent>(initEv); 

    on<ChoiseHotelEvent>(chooiseHotel); //((event, emit) => emit(ChoiseStateHomeState()));
    on<ChoiseBuildingEvent>(chooiseBuilding); //((event, emit) => emit(ChoiseStateBuildingState()));
    on<ChoiseRoomEvent>(chooiseRoom); //((event, emit) => emit(ChoiseStateRoomState()));

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

  initEv(ChoiseInitEvent event, Emitter<ChoiseState> emit)async {
    providerData = Provider.of<DataProviderApp>(event.contextW, listen: false);
    if(providerData != null){
      providerData!.startP();
      await getHome();
    }
  }

  getHome() async{
    var result =await  providerData!.getHotels();
    _hotels = result;
    //render(_hotelChoise);
    // if(_hotelChoise != null){
    //   chooiseHotel(ChoiseHotelEvent(_hotelChoise!["id"]), emit );
    // }else{
    //   _hotelChoise = null;
    //   _buildingChoise = null;
    //   _roomChoise = null;
    //   chooiseHotel(ChoiseHotelEvent(null), emit );
    // }
    ///render
    emit(ChoiseStateInitState2(_hotels, null));
  }

  chooiseHotel(ChoiseHotelEvent event, Emitter<ChoiseState> emit) async{
    _hotelChoise = event.idHotel;
    var result =await  providerData!.getBuilders(id: event.idHotel!["id"]);
    _buildings = result;
    
    if(_buildingChoise != null){
      ///render
      emit(ChoiseStateInitState2(_hotels, _hotelChoise));
      emit(ChoiseStateHotelState(_hotelChoise, _buildings));  
      // chooiseBuilding(ChoiseBuildingEvent(_buildingChoise), emit);
    }else{
      _hotelChoise = null;
      _buildingChoise = null;
      _roomChoise = null;
      emit(ChoiseStateInitState2(_hotels, _hotelChoise));
      emit(ChoiseStateHotelState(_hotelChoise, _buildings));  
      //chooiseBuilding(ChoiseBuildingEvent(null), emit);
    }
  }

  chooiseBuilding(ChoiseBuildingEvent event, Emitter<ChoiseState> emit) async{
    _buildingChoise = event.idBuilding;
    var result = await  providerData!.getRooms(id: event.idBuilding!["id"]);
    _rooms = result;
    
    if(_roomChoise != null){
      ///render
      emit(ChoiseStateBuildingState(_buildingChoise, _rooms));
      chooiseRoom(ChoiseRoomEvent(_roomChoise), emit);
    }
  }

  chooiseRoom(ChoiseRoomEvent event, Emitter<ChoiseState> emit) async{
    _roomChoise = event.idRoom;
    if(_roomChoise !=null){
      ///render
      emit(ChoiseStateRoomState(_roomChoise));
    }
  }

  getPassCode(ChoiseRoomEvent event, Emitter<ChoiseState> emit)async{
    var result = await  providerData!.getPass(id: _roomChoise!['id']);
    if(result != null){
      ///render
      emit(ResultpassCode(result));  
    }
  }



}