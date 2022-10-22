import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musayi/admin/adminDrawer.dart';
import 'package:musayi/user/info/loading.dart';

class bloodbanks extends StatefulWidget {
  @override
  _bloodbankState createState() => _bloodbankState();
}

class _bloodbankState extends State<bloodbanks> {
  final Stream<QuerySnapshot> _bloodlevels =
      FirebaseFirestore.instance.collection('APPOINTMENTS').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bloodlevels,
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
              title: Text('MONITOR BLOOD LEVELS'),
              backgroundColor: Colors.red,
              centerTitle: true,
            ),
            drawer: SideMenu(),
            body: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Column(children: <Widget>[
                  Center(
                      child:Text('BLOOD BANKS')),
                  Card(
                    child: ListTile(
                      title: Text(data['name']),
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/3.jpg")),
                      trailing: FloatingActionButton.extended(
                        label: const Text('Monitor'),
                        onPressed: () {},
                      ),
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
