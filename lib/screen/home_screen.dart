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
  
  late DataProviderApp  providerSetttings;

  List tableList = List.empty(growable: true);

  @override
  void initState() {
    providerSetttings = Provider.of<DataProviderApp>(context, listen: false);
    providerSetttings.startP();
    super.initState();
  }

  @override
  void dispose() {
    providerSetttings.closeP();
    providerSetttings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // width: 500,
          // height: 400,
          color:Colors.white,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine("Выберите отелей", providerSetttings.getHotels())
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: _choiseLine("Выберите корпус", providerSetttings.getBuilders())
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
              child: _choiseLine("Выберите номер", providerSetttings.getRooms()),
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

  Widget _choiseLine(String title, Future objectEvent) {
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
                  return _check(title, assync.data);  
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

  String? _dropDownValue;

  Widget _check(String hint, List listData) {
    return DropdownButton(
      hint: _dropDownValue == null
          ? Text(hint)
          : Text(
              _dropDownValue ?? "",
              style: TextStyle(color: Colors.green),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.green),
      items: listData.map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            if (val != null) _dropDownValue = val.toString();
          },
        );
      },
    );
  }

  Widget _buttonResponse() {
    return ButtomAnimationTupCustom(
      tap: () async {
        var result = await providerSetttings.getPass();
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
                  child: Text("+7932== ${index} - 283733"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("2022.03.2"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("2022.05.12"),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Text("3455023"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
