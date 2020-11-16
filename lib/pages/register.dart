import 'package:flutter/material.dart';
import '../plugins/firebaseAuth.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
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
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: new TextStyle(color: Colors.black, fontSize: 25),
                    decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(color: Colors.black, fontSize: 25),
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black)),
                      controller: email),
                  TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: new TextStyle(color: Colors.black, fontSize: 25),
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: senha),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: new TextStyle(color: Colors.black, fontSize: 25),
                    decoration: InputDecoration(
                        labelText: "Confirmar Senha",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  ButtonTheme(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () async {
                        var emailTxt = email.text;
                        var senhaTxt = senha.text;
                        dynamic result = await createUserWithEmailAndPassword(
                            emailTxt, senhaTxt);
                        if (result == true)
                          Navigator.popAndPushNamed(context, '/home');
                      },
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )));
  }
}
