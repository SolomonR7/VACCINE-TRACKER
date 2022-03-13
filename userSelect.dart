// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class UserSelPage extends StatefulWidget {
  @override
  _UserSelPageState createState() => _UserSelPageState();
}

class _UserSelPageState extends State<UserSelPage>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: const Text('Vaccine',
                    style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold)),
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
          padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/adlog');
            },
              child: Container(
                height: 50,

                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,

                      child: Center(
                        child: Text(
                          'CENTRE LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),),
              SizedBox(height: 50),
              Container(
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,

                      child: Center(
                        child: Text(
                          'CITIZEN LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              ],
          ),

        ),
      ],)
    );
  }
}