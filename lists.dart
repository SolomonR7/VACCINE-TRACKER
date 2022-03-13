// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_field, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class listpage extends StatefulWidget {

  @override
  _listpageState createState() => _listpageState();
}

class _listpageState extends State<listpage> {
  final _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  db = FirebaseFirestore.instance;


  _signOut() async {
    await _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vaccine Tracker'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            ElevatedButton(
              child: Center(
                child: Text("Log Out",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
                  ),
                ),
              onPressed: ()async{
                await _signOut();
                if (_auth.currentUser == null){
                  Navigator.of(context).pop();
                }
              },
            style: ElevatedButton.styleFrom(
            primary: Colors.green
            ),

            ),
          ],

        ),

        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[

          Expanded(
          child: Container(

            child: FutureBuilder<QuerySnapshot>(
              future:  db.collection('centers').get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData) {

                  return ListView(
                      shrinkWrap: false,
                      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                      controller: _scrollController,
                      children: snapshot.data!.docs.map((doc){
                        return Card(
                          color:  Colors.green[200],
                          child:  ListTile(
                            title: Text((doc.data() as dynamic)['NAME'].toString()),
                            onTap: () async {
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                return Container(
                                    child: SimpleDialog (
                                      title: Text("  VACCINE DETAILS"),
                                      children: [
                                        Text("COVAXIN: " + (doc.data() as dynamic)['covaxin'].toString()),
                                        Text("COVISHIELD: " + (doc.data() as dynamic)['covishield'].toString()),
                                      ],
                                      elevation: 10,
                                      backgroundColor: Colors.greenAccent,
                                      shape: StadiumBorder(),
                                      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 16.0),
                                    ),
                                );
                                  }
                              );

                            },
                          ),


                        );
                      }).toList()
                  );


                } else  if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());

              }
                else {
                  return Text('Error!');
                }
              }
          ),
          ),),
          Container(
            padding: const EdgeInsets.fromLTRB(50.0, 20.0, 0.0, 5.0),


            child: TextButton(
              child: Text('Search for centers near you!', style: TextStyle(fontSize: 20.0),),
              onPressed: () {
                Navigator.of(context).pushNamed('/filteredpage');
              },
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent
              ),



            ),
          ),
    ],
        ),

    );
  }
}
