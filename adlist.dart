// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_field, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class adlistpage extends StatefulWidget {
  
  @override
  _adlistpageState createState() => _adlistpageState();
}

class _adlistpageState extends State<adlistpage> {
  final _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  db = FirebaseFirestore.instance;

  _signOut() async {
    await _auth.signOut();
  }

  // Generate dummy data to fill the ListView
  //final List<String> listItems = List.generate(10, (i) => "Center $i");

  // Define the fixed height for an item
  String cid='';

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

        body:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
          Expanded(
            child:Container(
          child: FutureBuilder<QuerySnapshot>(
              future:  db.collection('centers').get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData) {

                  return ListView(
                      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                      controller: _scrollController,
                      children: snapshot.data!.docs.map((doc){
                        return Card(
                          color:  Colors.green[200],
                          child:  ListTile(
                            title: Text((doc.data() as dynamic)['NAME'].toString()),
                            onTap: ()  async{
                               cid= (doc.data() as dynamic)['NAME'].toString();

                              showDialog(context: context,
                                  builder: (BuildContext context){
                                    return Expanded(
                                      child: SimpleDialog (
                                        title: Text("     VACCINE DETAILS"),
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                                            child: Text("COVAXIN: " + (doc.data() as dynamic)['covaxin'].toString(),style: TextStyle(fontSize: 18)),
                                          ),
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                                      child: Text("COVISHIELD: " + (doc.data() as dynamic)['covishield'].toString(),style: TextStyle(fontSize: 18)),
                                    ),
                                          Container(
                                               child: SimpleDialogOption(
                                              padding: EdgeInsets.fromLTRB(70, 8, 0, 20),
                                              onPressed: () {
                                              var cvxval= int.parse((doc.data() as dynamic)['covaxin'].toString());
                                              cvxval=cvxval+10;
                                               db.collection("centers").doc(cid).update({'covaxin': cvxval.toString()});
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "BATCH ADDED SUCCESSFULLY"),
                                                  ));
                                               },
                                            child: const Text('Add cvx batch',style: TextStyle(fontSize: 17,color: Colors.deepPurpleAccent)),
                                          ),
                                          ),
                                          Container(
                                            child: SimpleDialogOption(
                                              padding: EdgeInsets.fromLTRB(70, 5, 0, 20),

                                            onPressed: () {
                                              var cshval= int.parse((doc.data() as dynamic)['covishield'].toString());
                                              cshval = cshval+25;
                                              db.collection("centers").doc(cid).update({'covishield': cshval.toString()});
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "BATCH ADDED SUCCESSFULLY"),
                                                  ));

                                            },
                                            child: const Text('Add csh batch',style: TextStyle(fontSize: 17,color: Colors.deepPurpleAccent),),

                                          ),
                                          ),
                                        ],
                                        elevation: 10,
                                        backgroundColor: Colors.greenAccent,
                                        shape: StadiumBorder(),
                                        //insetPadding: EdgeInsets.all(50),
                                        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 16.0),
                                        titlePadding: const EdgeInsets.fromLTRB(25, 25, 20, 10),
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
          ),),
        )])

    );
  }
}
