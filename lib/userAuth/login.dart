import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waifucarecenter/config/loader.dart';
import 'package:http/http.dart'as http;

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool keepLoginData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.addListener(checkUsername);
    password.addListener(checkPassword);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Username"),
              controller: this.username,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "password"),
              controller: this.password,
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Save login data"),
                Checkbox(
                    value: keepLoginData,
                    onChanged: (bool _val) {
                      setState(() {
                        keepLoginData = _val;
                      });
                    }),
              ],
            ),
            FloatingActionButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingHandler<String>(
                              future: bela,
                          succeeding: (String data){
                                print(data);
                                return Scaffold(body: Text(data));
                          },
                            )));
              },
            )
          ],
        ),
      ),
    );
  }

  bool checkUsername() {
    print(this.username.text);
    return true;
  }

  bool checkPassword() {
    return true;
  }

  Future<String> bela() async {
    //new Future.delayed(Duration(seconds: 3));
    final response = await http.get("http://192.168.1.66:3000").timeout(Duration(seconds: 3));
    return response.body;
  }
}
