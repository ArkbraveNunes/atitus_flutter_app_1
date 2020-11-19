import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTask extends StatefulWidget {
  EditTask({this.title, this.duedate, this.note, this.index});
  String title;
  String note;
  DateTime duedate;
  final index;
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController controllerTitle;
  TextEditingController controllerNote;
  DateTime _dueDate;
  String _dateText = "";
  String newTask;
  String note;

  void _editTask() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(widget.index);
      await transaction.update(documentSnapshot.reference,
          {"title": newTask, "note": note, "duedate": _dueDate});
    });
    Navigator.pop(context);
  }

  // _updateTask

  Future _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dueDate = widget.duedate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
    newTask = widget.title;
    note = widget.note;
    controllerTitle = new TextEditingController(text: widget.title);
    controllerNote = new TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/bg.jpg"), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "RememberMe",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2,
                      fontFamily: "Pacifico"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Editar Tarefa",
                      style: new TextStyle(fontSize: 24, color: Colors.white)),
                ),
                Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerTitle,
              onChanged: (String str) {
                setState(() {
                  newTask = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.dashboard),
                  hintText: "Título da Tarefa",
                  border: InputBorder.none),
              style: new TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.date_range),
                ),
                Expanded(
                  child: Text(
                    "Data",
                    style: new TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ),
                FlatButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text(
                    _dateText,
                    style: new TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controllerNote,
              onChanged: (String str) {
                setState(() {
                  note = str;
                });
              },
              decoration: new InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: "Descrição",
                  border: InputBorder.none),
              style: new TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 40,
                    ),
                    onPressed: () {
                      _editTask();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
