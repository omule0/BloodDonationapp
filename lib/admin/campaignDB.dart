import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignDb {
  CampaignDb();

  //collection reference
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('CAMPAIGNS');

  //method to write data to firestore
  Future<void> createCampaign(
    String center,
    String location,
    String date,
    String time,
    String message,
  ) async {
    return await myCollection.doc().set({
      'center': center,
      'location': location,
      'date': date,
      'time': time,
      'message': message,
    });
  }
}
