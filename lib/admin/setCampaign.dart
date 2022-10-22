import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:musayi/user/appointments/database.dart';

import 'campaignDB.dart';

class setCampaigns extends StatefulWidget {
  const setCampaigns({Key key}) : super(key: key);

  @override
  State<setCampaigns> createState() => _createState();
}

class _createState extends State<setCampaigns> {
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('CAMPAIGNS');

  final _formKey = GlobalKey<FormState>();

  TextEditingController centerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //pick date of birth
  pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null) {
      setState(() {
        dateController.text = date.year.toString() +
            "-" +
            date.month.toString() +
            "-" +
            date.day.toString();
      });
    }
  }

  //pick time
  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
    );
    if (newTime != null) {
      setState(() {
        timeController.text = newTime.hour.toString() +
            ':' +
            newTime.minute.toString() +
            '' +
            newTime.period.toString();
      });
    }
  }

  //location
  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.locality}, ${placemark.administrativeArea}';
    locationController.text = completeAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SET CAMPAIGN'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: Builder(builder: (context) {
          return Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DropdownButtonFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) => value == null
                              ? 'Choose blood donation centre'
                              : null,
                          onChanged: (val) {
                            centerController.text = val;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          hint: Text("Blood Collection Centre"),
                          items: [
                            DropdownMenuItem(
                              child: Text(" Nakasero Blood Bank"),
                              value: "Nakasero",
                            ),
                            DropdownMenuItem(
                              child: Text("Arua Regional Blood Bank"),
                              value: "Arua Regional Referral Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Gulu Regional Blood Bank"),
                              value: "Gulu Regional Referral Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Fort Portal Regional Blood Bank"),
                              value: "Fort Portal Regional Referral Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Lira Regional Blood Bank"),
                              value: "Lira Regional Referral Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Masaka Regional Blood Bank"),
                              value: "Masaka Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Mbale Regional Blood Bank"),
                              value: "Mbale Hospital",
                            ),
                            DropdownMenuItem(
                              child: Text("Mbarara Regional Blood Bank"),
                              value: "Mbarara Regional Referral Hospital",
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Location of the event';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  onPressed: getUserLocation),
                              hintText:
                                  "Within area of event ? tap to get location",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          controller: locationController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onTap: () {
                            pickDate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Set date for the campaign';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Date for donation ?",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.pinkAccent),
                          controller: dateController,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: timeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TIME',
                        ),
                        onTap: () {
                          _selectTime();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          maxLines: 10,
                          // <-- SEE HERE
                          minLines: 1,
                          // <-- SEE HERE
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campaign message';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "CAMPAIGN MESSAGE",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          controller: messageController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await CampaignDb().createCampaign(
                              centerController.text,
                              locationController.text,
                              dateController.text,
                              timeController.text,
                              messageController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "CREATE",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }));
  }
}
