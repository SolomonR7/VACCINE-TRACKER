// ignore_for_file: unnecessary_new, prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

class SignupPage extends StatefulWidget {
  //final firestoreInstance = FirebaseFirestore.instance;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
    String email="",username="", password="",city="",pin="";

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //get firestoreInstance => null;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[


          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),

              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (value) {
                      username = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        labelText: 'USERNAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),

                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (value) {
                      password = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                  ),


                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (value) {
                      city = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        labelText: 'CITY ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),

                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (value) {
                      pin = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        labelText: 'PINCODE ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),

                  ),
                  SizedBox(height: 50.0),
                  // ignore: sized_box_for_whitespace
                  Container(

                      height: 40.0,
                      child: GestureDetector(
                        onTap: () async{
                          try {
                            final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);


                            if (newuser != null) {
                              var firebaseUser =  FirebaseAuth.instance.currentUser;
                              users.doc(firebaseUser!.uid).set(
                                    {
                                      'email': email,
                                      'username': username,
                                      'city': city,
                                      'pincode': pin

                                    })
                                    .then((value) => print("User Added"))
                                    .catchError((error) => print("Failed to add user: $error"));



                              Navigator.of(context).pop();

                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,

                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:

                        Center(
                          child: Text('GO BACK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),


                      ),
                    ),
                  ),
                ],
              )),

        ]));
  }
}