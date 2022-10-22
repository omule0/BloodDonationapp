import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musayi/user/authentication/google_auth_logic.dart';

//initialise firebase and App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MusayiApp());
}

class MusayiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MUSAYI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen());
  }
}
