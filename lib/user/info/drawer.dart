import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musayi/user/appointments/campaigns.dart';

class MainDrawer extends StatefulWidget {
  final GoogleSignIn googleSignIn;

  MainDrawer(this.googleSignIn);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.googleSignIn.currentUser.photoUrl),
              ),
            ),
            ListTile(
              title: Text(
                'Campaigns',
                style: TextStyle(
                    color: Colors.black, fontFamily: "Gotham", fontSize: 16.0),
              ),
              leading: Icon(
                Icons.newspaper_rounded,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => campaigns()));
              },
            ),
            ListTile(
              title: Text(
                'Sign out',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () {
                widget.googleSignIn.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
