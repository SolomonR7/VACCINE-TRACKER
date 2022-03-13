// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_field, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class filteredpage extends StatefulWidget {

  @override
  _filteredpageState createState() => _filteredpageState();
}

class _filteredpageState extends State<filteredpage> {
  final _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  db = FirebaseFirestore.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //var document = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
  var pin=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

  //Future<DocumentSnapshot<Map<String, dynamic>>> pincode=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
 // String pin = pincode.get("pincode");
  //var pin = FirebaseFirestore.instance.collection('users').where('pincode',isEqualTo: '632006').get();

 String pinc ='';
  _signOut() async {
    await _auth.signOut();
  }

  pincode() {
    var pin= FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    pin.get().then((pin) => {
      pinc=(pin.data() as dynamic)['pincode'].toString()
    });
    return pinc;
  }
  String res='';
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
         /* document.get() => then((document) {
            print(document("name"));
          }),*/
              future:  db.collection('centers').where('Pincode',isEqualTo: res=pincode()).get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData) {

                  return ListView(
                      shrinkWrap: true,
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
                  return Text('SORRY NO VACCINE CENTRE AVAILABLE IN YOUR AREA');
                }
              }
          ),

    ))
    ],
    ),
    );
  }
}
