import 'package:flutter/material.dart';
import '../plugins/firebaseAuth.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(userModel.photo),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Sign Out??",
                style: new TextStyle(fontSize: 16),
              ),
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    signOutGoogle();
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(5),
                      ),
                      Text("Yes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(5),
                      ),
                      Text("No")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/task/new');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // bottomNavigationBar: new BottomAppBar(
      //   elevation: 20,
      //   color: Colors.black,
      //   child: ButtonBar(
      //     children: <Widget>[],
      //   ),
      // ),
      body: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("img/bg.jpg"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              new BoxShadow(color: Colors.white, blurRadius: 8.0),
            ]),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: new NetworkImage(userModel.photo),
                            fit: BoxFit.cover)),
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "Welcome",
                            style: new TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          new Text(
                            userModel.name,
                            style: new TextStyle(
                                fontSize: 24, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  new IconButton(
                      icon: Icon(Icons.exit_to_app,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        _signOut();
                      })
                ],
              ),
            ),
            new Text(
              "My Task",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontFamily: "Pacifico"),
            ),
          ],
        ),
      ),
    );
  }
}
