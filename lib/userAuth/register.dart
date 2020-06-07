import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  @override
  LoginState createState()=>LoginState();
}
class LoginState extends State<LoginScreen>{
  final username=TextEditingController();
  final password=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.addListener(checkUsername);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Column(children: <Widget>[
      TextFormField(controller: this.username,decoration: InputDecoration(hintText: "Email"),),
      TextFormField(controller: this.password,),
      FloatingActionButton(child: Text("Login"),onPressed:()=>{
      },)
    ],),);
  }
  bool checkUsername(){
    print(this.username.text);
    return true;
  }
  bool checkPassword(){
    return true;
  }
}