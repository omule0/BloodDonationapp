import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogs/dialogs/choice_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musayi/user/info/loading.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('APPOINTMENTS');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('APPOINTMENTS').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return circularLoading();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularLoading();
        }

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('MANAGE APPOINTMENTS'),
              backgroundColor: Colors.red,
              centerTitle: true,
            ),
            body: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Card(
                  elevation: 2.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0)),
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'NAME :  ' + data['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'DATE :  ' + data['date'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'TIME :  ' + data['time'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'CENTER :  ' + data['center'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'TEL :  ' + data['contact'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        'STATUS :  ' + data['status'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text('Cancel Appointment'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal),
                                      ),
                                      onPressed: () {
                                        ChoiceDialog(
                                          title: 'CANCEL APPOINTMENT',
                                          titleColor: Colors.red,
                                          message:
                                              'Are you sure you want to cancel this appointment ?',
                                          buttonCancelOnPressed: () {
                                            Navigator.pop(context);
                                          },
                                          buttonOkOnPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("APPOINTMENTS")
                                                .doc(document
                                                    .id) // Replace the document.documentID with the row id that you need to delete
                                                .delete()
                                                .catchError((e) {
                                              print(e);
                                            });
                                            Navigator.pop(context);
                                          },
                                        ).show(context);
                                        //cancel appointment
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
