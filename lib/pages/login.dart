import 'package:flutter/material.dart';
import '../plugins/firebaseAuth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "img/logo.png",
                    width: 200,
                    height: 200,
                  ),
                  Divider(
                    height: 20,
                  ),
                  Center(
                      child: new Text(
                    "RememberMe",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        letterSpacing: 2,
                        fontFamily: "Pacifico"),
                  )),
                  Divider(
                    height: 20,
                  ),
                  new InkWell(
                    onTap: () {
                      signInWithGoogle().then((result) => result == true
                          ? Navigator.popAndPushNamed(context, '/home')
                          : null);
                    },
                    child: new Image.asset(
                      "img/googleSignIn.png",
                      width: 300.0,
                    ),
                  )
                ],
              ),
            )));
  }
}
