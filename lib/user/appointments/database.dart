import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  DataBase();

  //collection reference
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('APPOINTMENTS');

  //method to write data to firestore
  Future<void> createAppointment(
    String name,
    String date,
    String time,
    String center,
    String contact,
    String region,
  ) async {
    return await myCollection.doc().set({
      'name': name,
      'date': date,
      'time': time,
      'center': center,
      'contact': contact,
      'region': region,
      'status': 'PENDING'
    });
  }
}
