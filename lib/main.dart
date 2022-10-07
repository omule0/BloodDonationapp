import 'package:flutter/material.dart';
import 'package:musayi/authentication/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

//initialise firebase and App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Musayi());
}

class Musayi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MUSAYI',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: LoginScreen(),
    );
  }
}