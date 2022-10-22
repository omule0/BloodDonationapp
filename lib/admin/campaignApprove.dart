import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musayi/user/info/loading.dart';

class Approvals extends StatefulWidget {
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approvals> {
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('APPOINTMENTS');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('APPOINTMENTS').snapshots();
  String status = 'APPROVE';
  Color color = Colors.grey;

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
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
                                padding: EdgeInsets.symmetric(vertical: 2.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        data['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        data['center'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        data['date'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: Text(
                                        data['time'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text('APPROVE'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      onPressed: () {
                                        myCollection
                                            .doc(document.id)
                                            .update({'status': 'APPROVED'});
                                        setState(() {
                                          status = 'APPROVED';
                                        });
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

/*ListTile(
                title: Text(data['phone']),
                subtitle: Text(data['name']),
              );*/
