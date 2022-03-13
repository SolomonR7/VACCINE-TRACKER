// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:apps/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'userSelect.dart';
import 'adlog.dart';
import 'lists.dart';
import 'adlist.dart';
import 'filtered.dart';


void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/userSelect': (BuildContext context) => UserSelPage(),
        '/adlog': (BuildContext context) => AdLogPage(),
        '/listpage': (BuildContext context) => listpage(),
        '/adlist': (BuildContext context) => adlistpage(),
        '/filteredpage': (BuildContext context) => filteredpage()

      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
          Container(
          padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
          child: const Text('Vaccine',
          style: TextStyle(
              fontSize: 80.0, fontWeight: FontWeight.bold,)),
    ),
         Container(
        padding: const EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
        child: const Text('Tracker',
        style: TextStyle(
        fontSize: 80.0, fontWeight: FontWeight.bold)),
    ),
    ],
    ),
    ),
         Container(
        padding: const EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
        child: const Text('One Place For All Things Vaccine',
        style: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.bold,color: Colors.green)),
    ),
            SizedBox(height: 60.0),
            Container(
              height: 80.0,
              padding: EdgeInsets.fromLTRB(16,40,16,0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/userSelect');
                },
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.greenAccent,
                color: Colors.green,
                elevation: 7.0,

                  child: Center(
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
    ],),


    );
  }
}