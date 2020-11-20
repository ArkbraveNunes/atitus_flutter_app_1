import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/home.dart';
import './pages/newTask.dart';
import './pages/editTask.dart';
import './database/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RememberMe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/task/new': (context) => NewTask(),
          '/task/edit': (context) => EditTask(),
        });
  }
}
