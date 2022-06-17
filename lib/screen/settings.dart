

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import '../provider/settings_app.dart';
import 'home_screen.dart';
import 'wind/create.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _token = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          margin:const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              butWind(),
              Container(
                child: _textFields(),
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.orange
                    ),
                  ),
                  onPressed: () async {
                    _confirm();
                  },
                  child:const Text("Подтвердить"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  _confirm() async{
    if (_formKey.currentState?.validate() ?? false) {
      SettingsProviderApp  provider = await Provider.of<SettingsProviderApp>(context, listen: false);
      await provider.setShelterToken(_token.text);           
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

  Widget _textFields(){
    return Form(
      key: _formKey,
      child:Column(
        children: [
          _textField(_token)
        ],
      ) ,
    );
  }

  _textField(TextEditingController controller){
    return TextFormField(
      controller: controller,
      decoration:const InputDecoration(
          border: OutlineInputBorder(
            // borderSide: BorderSide(color: noerrore ? Colors.grey : Colors.red ),
            borderRadius:const BorderRadius.all(Radius.circular(12))
          ),
          // icon: Icon(Icons.login),
          hintText: "Shelter token",
          helperText: "",
      ),
      validator: (value){
          // String p = "[a-zA-Z0-9+._%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
          // RegExp regExp = new RegExp(p);
          if(value != null)
            if (value.isEmpty){
              return "Пустое поле";
            }else if(value.length <2){
              return "Это не Shelter token";
            }
            // else if (regExp.hasMatch(value)){
            //   return null;
            // }
      }
    );
  }


}