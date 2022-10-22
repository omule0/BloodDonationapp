import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:musayi/user/appointments/database.dart';

class create extends StatefulWidget {
  const create({Key key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  CollectionReference myCollection =
      FirebaseFirestore.instance.collection('APPOINTMENTS');
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController centerDateController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
        dateController.text = date.day.toString() +
            '/' +
            date.month.toString() +
            '/' +
            date.year.toString();
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
            ' ' +
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
        '${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
    locationController.text = completeAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('APPOINTMENT FORM'),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Your full name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          controller: nameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          onTap: () {
                            pickDate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Choose Date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "When will you be ready ?",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              fillColor: Colors.pinkAccent),
                          controller: dateController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          onTap: () {
                            _selectTime();
                          },
                          decoration: InputDecoration(
                              hintText: "Time of appointment",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          controller: timeController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: DropdownButtonFormField(
                          validator: (value) => value == null
                              ? 'Choose blood donation centre'
                              : null,
                          onChanged: (val) {
                            centerDateController.text = val;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                          hint: Text("Centre"),
                          items: [
                            DropdownMenuItem(
                              child: Text("Nakasero Blood Bank"),
                              value: "Nakasero Blood Bank",
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
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          validator: (value) {
                            if (value.isEmpty ||
                                value.length != 10 ||
                                value.length > 10) {
                              return 'Enter Your contact';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Phone Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          controller: contactController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tap to get your location';
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
                              hintText: "Your current Location",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          controller: locationController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DataBase().createAppointment(
                                nameController.text,
                                dateController.text,
                                timeController.text,
                                centerDateController.text,
                                contactController.text,
                                locationController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Submitting request...')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }));
  }
}
