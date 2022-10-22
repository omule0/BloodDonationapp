import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogs/dialogs/choice_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musayi/user/info/loading.dart';

class campaigns extends StatefulWidget {
  @override
  _campaignsState createState() => _campaignsState();
}

class _campaignsState extends State<campaigns> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('CAMPAIGNS').snapshots();

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
              title: Text('COMMUNITY CAMPAIGNS'),
              backgroundColor: Colors.redAccent,
              centerTitle: true,
            ),
            body: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 150,
                    width: double.infinity,
                    color: Colors.black12,
                    child: Stack(
                      children: <Widget>[
                        Container(
                            height: 150.0,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.black26,
                                    alignment: Alignment.center,
                                    child: Text(data['location'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.black26,
                                    alignment: Alignment.center,
                                    child: Text(data['center'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.black26,
                                    alignment: Alignment.center,
                                    child: Text(data['date'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.black26,
                                    alignment: Alignment.center,
                                    child: Text(data['time'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: ListView(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(data['message'],
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
