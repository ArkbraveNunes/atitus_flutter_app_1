import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/editTask.dart';
import 'package:flutter_project/pages/newTask.dart';
import 'package:intl/intl.dart';
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
                "Deseja fazer logoff?",
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
                      Text("Sim")
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
                      Text("Não")
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
      body: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('task')
                  .where("email", isEqualTo: userModel.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                return new TaskList(
                  document: snapshot.data.docs,
                );
              },
            ),
          ),
          Container(
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
                                "Bem vindo",
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
                  "RememberMe",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2,
                      fontFamily: "Pacifico"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  TaskList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String title = document[i].data()['title'].toString();
        String note = document[i].data()['note'].toString();
        DateTime _date = new DateTime.fromMillisecondsSinceEpoch(
            document[i].data()['duedate'].seconds * 1000);
        String duedate = "${_date.day}/${_date.month}/${_date.year}";
        return Dismissible(
          key: new Key(document[i].id),
          onDismissed: (direction) {
            FirebaseFirestore.instance
                .runTransaction((Transaction transaction) async {
              DocumentSnapshot documentSnapshot =
                  await transaction.get(document[i].reference);
              await transaction.delete(documentSnapshot.reference);
            });
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text("Tarefa Deletada")));
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child:
                                  Icon(Icons.date_range, color: Colors.black),
                            ),
                            Text(
                              duedate,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(Icons.note, color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                note,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => new EditTask(
                                title: title,
                                note: note,
                                duedate:
                                    new DateTime.fromMillisecondsSinceEpoch(
                                        document[i].data()['duedate'].seconds *
                                            1000),
                                index: document[i].reference,
                              )));
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
