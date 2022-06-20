import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_get_passlock/screen/settings.dart';

import '../button_widget.dart';
import '../provider/data_provider.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _IntroScreen()
      ),
    );
  }

}

class _IntroScreen extends StatefulWidget {
  const _IntroScreen({Key? key}) : super(key: key);

  @override
  State<_IntroScreen> createState() => __IntroScreenState();
}

class __IntroScreenState extends State<_IntroScreen> {
   late DataProviderApp  providerData;

  List tableList = List.empty(growable: true);
  
  String? _dropDownValueHotels;
  String? _dropDownValueBuildings;
  String? _dropDownValueRooms;
  String? _idRoom;
  String? _idHotel;
  String? _idBuilding;

  bool _renderFinish_Hotel = false;
  bool _renderFinish_Buildings = false;
  bool _renderFinish_Rooms = false;

  @override
  void initState() {
    providerData = Provider.of<DataProviderApp>(context, listen: false);
    providerData.startP();
    super.initState();
  }

  @override
  void dispose() {
    providerData.closeP();
    providerData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          color:Colors.white,
          margin: const EdgeInsets.all(15),
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine(
                  "Выберите отель", 
                  "name",
                  providerData.getHotels(),
                  _dropDownValueHotels,
                  (value){
                    _dropDownValueHotels = value;
                    if(_renderFinish_Hotel == true){
                      _renderFinish_Hotel = false;
                      _renderFinish_Buildings = false;
                      _renderFinish_Rooms = false;
                    } 
                    _renderFinish_Hotel = true;
                   
                  },
                (renderFinish){
                  // _renderFinish_Hotel = renderFinish;
                },
                (value){
                  _idHotel = value;
                }
                )
            ),
             !_renderFinish_Hotel ? SizedBox() :
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine(
                  "Выберите корпус", 
                  "name",
                  providerData.getBuilders(id:_idHotel),
                  _dropDownValueBuildings,
                  (value){
                    _dropDownValueBuildings = value;
                     _renderFinish_Buildings = true;
                  },
                (renderFinish){
                  // _renderFinish_Buildings = renderFinish;
                },
                (value){
                  _idBuilding = value;
                }
                )
            ),
            !_renderFinish_Buildings ? SizedBox() :
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
              child: _choiseLine(
                "Выберите номер", 
                "number",
                providerData.getRooms(id:_idBuilding),
                _dropDownValueRooms,
                (value){
                  _dropDownValueRooms = value;
                   _renderFinish_Rooms = true;
                },
                (renderFinish){
                  // _renderFinish_Rooms = renderFinish;
                },
                (value){
                  _idRoom = value;
                }
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [Spacer(), _buttonResponse()],
              ),
            ),
            Row(
              children: [
                Container(
                  child: Text("Телефон"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text(" Дата с "),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text(" Дата по "),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("Код замка"),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _lisstResult()
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
              child: Container(

                child:const Icon(Icons.settings, color: Colors.amber, size: 40,),
                //child: Text("Настройки"),
              ),
            )
          ]),
        );
  }

  Widget _choiseLine(
    String title,
    String field,
    Future objectEvent,
    String? value,
    Function(String) valueFunc,
    Function(bool) finishRender,
    Function(String) valueId
  ) {
    return Row(
      children: [
        Container(
          child: Text(title),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
           child: FutureBuilder(
              future: objectEvent,
              builder: (context, AsyncSnapshot assync) {
                
                if(assync.hasData && assync.data != null){
                  if(title == "Выберите корпус"){
                    List listt = assync.data;
                    List listData = listt.where((element) {
                          if(element['hotel'] == _idHotel){
                            return true;
                          }else{
                            return false;
                          } 
                     }).toList();
                    finishRender(true);
                    return _check(title, field, listData, value, (value){
                      valueFunc(value);
                    },
                    (value){
                      valueId(value);
                    }
                    );
                  }
                  if(title == "Выберите номер"){
                    List listt = assync.data;
                    List listData = listt.where((element) {
                          if(element['building'] == _idBuilding){
                            return true;
                          }else{
                            return false;
                          } 
                     }).toList();
                    finishRender(true);
                    return _check(title, field,listData, value, (value){
                      valueFunc(value);
                    },
                    (value){
                      valueId(value);
                    }
                    );
                  }
                  finishRender(true);
                  return _check(title, field, assync.data, value, (value){
                    valueFunc(value);
                  },
                  (value){
                    valueId(value);
                  }
                  );  
                }
                return SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator()
                );
              }
            ),
          ),
        )
      ],
    );
  }


  Widget _check(String hint, String field, List listData, String? value, Function(String) valueFunc, Function(String) valueId) {
    return DropdownButton<Map>(
      hint: value == null
          ? Text(hint)
          : Text(
              value ,
              style: TextStyle(color: Colors.green),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.green),
      items: listData.map(
        (val) {
          return DropdownMenuItem<Map>(
            value: val,
            child: Text(val[field].toString()),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            if (val != null){
              valueFunc(value = val[field].toString()); //value = val.toString();
              valueId(value = val['id'].toString());
              if("Выберите номер" == hint) _idRoom = val["id"];
            } 
          },
        );
      },
    );
  }

  Widget _buttonResponse() {
    return ButtomAnimationTupCustom(
      tap: () async {
         if(true){
          var result = await providerData.getPass(id: _idRoom);
          if(result != null)
            setState(() {
              tableList = result;
            });   
         } 
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.all(10),
        child: const Center(child: Text("узнать код")),
      ),
      parent: (childWidget) {
        return childWidget;
      },
    );
  }

  Widget _lisstResult() {
    return ListView.builder(
      itemCount: tableList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Divider(),
            Row(
              children: [
                Container(
                  child: Text("${tableList}"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("${tableList}"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("${tableList}"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("${tableList}"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
