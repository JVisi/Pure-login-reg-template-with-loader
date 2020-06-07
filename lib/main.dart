import 'package:flutter/material.dart';
import 'package:waifucarecenter/config/core.dart';
import 'package:waifucarecenter/userAuth/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), ///check memory
    );
  }
}