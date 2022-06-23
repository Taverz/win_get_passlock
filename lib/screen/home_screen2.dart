

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:ScreenMain2()  ,
      ),
    );
  }
}
class ScreenMain2 extends StatefulWidget {
  const ScreenMain2({Key? key}) : super(key: key);

  @override
  State<ScreenMain2> createState() => __ScreenState();
}

class __ScreenState extends State<ScreenMain2> {

   late DataProviderApp  providerData;

   
  @override
  void initState() {
    providerData = Provider.of<DataProviderApp>(context, listen: false);
    providerData.startP();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:SingleChildScrollView(
        child: Column(children: [
          
        ]),
      ) ,
    );
  }

  Widget _listSelect(){
    return Column(
      children: [
        _choiseLine1()
      ],
    );
  }

  String _check1 = '';

  Widget _choiseLine1() {
    return Row(
      children: [
        Container(
          child: Text("title"),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
           child: FutureBuilder(
              future: providerData.getRooms(id:"1"),
              builder: (context, AsyncSnapshot assync) {
                if(assync.hasData && assync.data != null){
                  return DropdownButton<Map>(
                        hint: _check1 == null
                            ? Text("hint")
                            : Text(
                                _check1 ,
                                style: TextStyle(color: Colors.green),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.green),
                        items: assync.data.map(
                          (val) {
                            return DropdownMenuItem<Map>(
                              value: val,
                              child: Text(val[""].toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                         //TODO: change
                        },
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
}