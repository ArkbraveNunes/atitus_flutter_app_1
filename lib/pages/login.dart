import 'package:flutter/material.dart';
import '../plugins/firebaseAuth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var senha = TextEditingController();

  String erro = "";
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
                  TextFormField(
                      onChanged: (value) => setState(() => this.erro = ""),
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(color: Colors.black, fontSize: 25),
                      decoration: InputDecoration(
                          labelText: "Login",
                          labelStyle: TextStyle(color: Colors.black)),
                      controller: email),
                  TextFormField(
                    onChanged: (value) => setState(() => this.erro = ""),
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: new TextStyle(color: Colors.black, fontSize: 25),
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: senha,
                  ),
                  Divider(),
                  ButtonTheme(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () async {
                        var emailTxt = email.text;
                        var senhaTxt = senha.text;
                        dynamic result = await signInWithEmailAndPassword(
                            emailTxt, senhaTxt);
                        if (result == true)
                          Navigator.popAndPushNamed(context, '/home');
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    height: 5,
                  ),
                  ButtonTheme(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    height: 10,
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
                  ),
                ],
              ),
            )));
  }
}

// new InkWell(
//   onTap: () {
//     signInWithGoogle().then((result) => result == true
//         ? Navigator.popAndPushNamed(context, '/first')
//         : null);
//   },
//   child: new Image.asset(
//     "img/googleSignIn.png",
//     width: 300.0,
//   ),
// ),
// new InkWell(
//   onTap: () {},
//   child: new Image.asset(
//     "img/facebookSignIn.png",
//     width: 300.0,
//   ),
// )
