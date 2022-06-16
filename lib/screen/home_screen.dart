import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../button_widget.dart';
import '../provider/data_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  late DataProviderApp  providerData;

  List tableList = List.empty(growable: true);
  
  String? _dropDownValueHotels;
  String? _dropDownValueBuildings;
  String? _dropDownValueRooms;
  String? _idRoom;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color:Colors.white,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine(
                  "Выберите отелей", 
                  "name",
                  providerData.getHotels(),
                  _dropDownValueHotels,
                  (value){
                    _dropDownValueHotels = value;
                  }
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine(
                  "Выберите корпус", 
                  "name",
                  providerData.getBuilders(),
                  _dropDownValueBuildings,
                  (value){
                    _dropDownValueBuildings = value;
                  }
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
              child: _choiseLine(
                "Выберите номер", 
                "number",
                providerData.getRooms(),
                _dropDownValueRooms,
                (value){
                  _dropDownValueRooms = value;
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
          ]),
        ),
      ),
    );
  }

  Widget _choiseLine(
    String title,
    String field,
    Future objectEvent,
    String? value,
    Function(String) valueFunc
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
                  return _check(title, field, assync.data, value, (value){
                    valueFunc(value);
                  });  
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


  Widget _check(String hint, String field, List listData, String? value, Function(String) valueFunc) {
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
        var result = await providerData.getPass(id: _idRoom);
        if(result != null)
          setState(() {
            tableList = result;
          });
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
