import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/choise_bloc.dart';
import '../bloc/choise_event.dart';
import '../bloc/choise_state.dart';
import '../button_widget.dart';
import '../provider/coise_provider.dart';
import '../provider/data_provider.dart';
import 'settings.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenMain2(),
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
  late DataProviderApp providerData;
  late ChoiseProvider providerChooise;
  // late ChooiseBloc blocChoise;

  @override
  void initState() {
    providerData = Provider.of<DataProviderApp>(context, listen: false);
    providerChooise = Provider.of<ChoiseProvider>(context, listen: false);
    providerData.startP();
    // blocChoise = ChooiseBloc(ChoiseStateInitState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerChooise.initEv(context,(){setState(() {
      
    });} );
    EdgeInsets marg =  const EdgeInsets.symmetric(vertical: 15);
    // blocChoise.add(ChoiseInitEvent(context));
    return Container(
       color:Colors.white,
          margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(children: [

        providerChooise.hotels == null ? SizedBox() :
          Container(
            margin:  marg,
            child: Row(
      children: [
        Container(
            child: Text("Choise hotel"),
        ),
        SizedBox(
            width: 20,
        ),
        Expanded(
            child: Container(
              child:
              //  FutureBuilder(
              //     future: providerData.getRooms(id: "1"),
              //     builder: (context, AsyncSnapshot assync) {
              //       if (assync.hasData && assync.data != null) {
                      // return 
                      DropdownButton<Map>(
                        hint: providerChooise.hotelChoise == null
                            ? Text("Choise hotel")
                            : Text(
                                providerChooise.hotelChoise!["name"],
                                style: TextStyle(color: Colors.green),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.green),
                        items:  providerChooise.hotels!.map(
                          (val) {
                            return DropdownMenuItem<Map>(
                              value: val,
                              child: Text(val["name"].toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          //TODO: change
                          providerChooise.chooiseHotel(val,  (){setState(() {
                            
                          });});
                        },
                      )
                  //     ;
                  //   }
                  //   return SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: CircularProgressIndicator());
                  // }),
            ),
        )
      ],
    ),
          ),


    providerChooise.buildings == null ? SizedBox() :
          Container(
            margin:  marg,
            child: Row(
      children: [
        Container(
            child: Text("Choise building"),
        ),
        SizedBox(
            width: 20,
        ),
        Expanded(
            child: Container(
              child:
              //  FutureBuilder(
              //     future: providerData.getRooms(id: "1"),
              //     builder: (context, AsyncSnapshot assync) {
              //       if (assync.hasData && assync.data != null) {
                      // return 
                      DropdownButton<Map>(
                        hint: providerChooise.buildingChoise == null
                            ? Text("Choise building")
                            : Text(
                                providerChooise.buildingChoise!["name"],
                                style: TextStyle(color: Colors.green),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.green),
                        items:  providerChooise.buildings!.map(
                          (val) {
                            return DropdownMenuItem<Map>(
                              value: val,
                              child: Text(val["name"].toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          //TODO: change
                          providerChooise.chooiseBuilding(val, (){setState(() {
                            
                          });});
                        },
                      )
                  //     ;
                  //   }
                  //   return SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: CircularProgressIndicator());
                  // }),
            ),
        )
      ],
    ),
          ),



    providerChooise.rooms == null ? SizedBox() :
          Container(
            margin:  marg,
            child: Row(
      children: [
        Container(
            child: Text("Choise room"),
        ),
        SizedBox(
            width: 20,
        ),
        Expanded(
            child: Container(
              child:
              //  FutureBuilder(
              //     future: providerData.getRooms(id: "1"),
              //     builder: (context, AsyncSnapshot assync) {
              //       if (assync.hasData && assync.data != null) {
                      // return 
                      DropdownButton<Map>(
                        hint: providerChooise.roomChoise == null
                            ? Text("Choise room")
                            : Text(
                                providerChooise.roomChoise!["number"],
                                style: TextStyle(color: Colors.green),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.green),
                        items:  providerChooise.rooms!.map(
                          (val) {
                            return DropdownMenuItem<Map>(
                              value: val,
                              child: Text(val["number"].toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          //TODO: change
                          providerChooise.chooiseRoom(val, (){setState(() {
                            
                          });});
                        },
                      )
                  //     ;
                  //   }
                  //   return SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: CircularProgressIndicator());
                  // }),
            ),
        )
      ],
    ),
          ),
    Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [Spacer(), _buttonResponse()],
              ),
            ),
        providerChooise.resultReq == null ? SizedBox() :
          // Expanded(
          //   child: 
          //    ListView.builder(
          //     itemCount: providerChooise.resultReq!.length,
          //     itemBuilder: (context, index){
          //       return 
          Container(
          //         margin:const EdgeInsets.all(10),
                  child: Wrap(children: [
                    Text( " Code: "+providerChooise.resultReq![0]["code"]+" "),
                    Text( " Phone: "+providerChooise.resultReq![0]["phone"]+" "),
                    Text( " Name: "+providerChooise.resultReq![0]["name"]+" "),
                    Text( " PeriodFrom: "+providerChooise.resultReq![0]["period_from"]+" "),
                    Text( " PeriodTo: "+providerChooise.resultReq![0]["period_to"]+" "),
                    Text( " FactualDate: "+providerChooise.resultReq![0]["factual_date"]+" ")
                   
                  ],)
                  // Text(providerChooise.resultReq.toString()),
            //     );
            //  })
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
      ),
    );
  }

  Widget _buttonResponse() {
    return ButtomAnimationTupCustom(
      tap: () async {
         if(providerChooise.roomChoise !=null){
          providerChooise.getPassCode( (){setState(() {
            
          });});
          // var result = await providerData.getPass(id: _idRoom);
          // if(result != null)
          //   setState(() {
          //     tableList = result;
          //   });   
         } 
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color:providerChooise.roomChoise ==null? Colors.red[300]: Colors.green[300],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.all(10),
        child: const Center(child: Text("узнать код")),
      ),
      parent: (childWidget) {
        return childWidget;
      },
    );
  }

}
