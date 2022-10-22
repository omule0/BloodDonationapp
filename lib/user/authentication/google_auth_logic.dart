import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musayi/admin/adminLogin.dart';
import 'package:musayi/user/appointments/database.dart';
import 'package:musayi/user/appointments/manage.dart';
import 'package:musayi/user/appointments/schedule.dart';
import 'package:musayi/user/info/drawer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DataBase currentUser;

  @override
  void initState() {
    super.initState();
    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });

    // Re-authenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  bool isAuth = false;

  loginWithGoogle() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

//screen for unauthenticated users
  Scaffold unAuthScreen() {
    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/blo.jpg"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/diabetes.png"), height: 200),
                //FlutterLogo(size: 150),
                SizedBox(height: 50),
                googleAuth(),
              ],
            ),
          ),
        ),
        //ADMIN BUTTON

        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            overlayColor: Colors.black,
            overlayOpacity: 0.4,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.admin_panel_settings_outlined),
                  label: "AdminLogin",
                  backgroundColor: Colors.red,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  }),
            ]));
  }

  Widget googleAuth() {
    return OutlinedButton(
      onPressed: () {
        loginWithGoogle();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 0,
        side: BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/img/g_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//screen for authenticated users
  Scaffold authScreen() {
    return Scaffold(
        appBar: AppBar(
          title: Text('MUSAYI APP'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        drawer: MainDrawer(googleSignIn),
        body: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/abc.jpg'), fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: const EdgeInsets.all(5),
              height: 25,
              width: double.infinity,
              color: Colors.redAccent,
              child: Center(
                  child: Text(
                      "Schedule an appointment today to donate blood and save a life",
                      style: TextStyle(color: Colors.white))),
            ),
            ElevatedButton(
              child: Text('SCHEDULE APPOINTMENT TO DONATE BLOOD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => create()));
              },
            ),
            ElevatedButton(
              child: Text('MANAGE APPOINTMENTS TO DONATE BLOOD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInformation()));
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? authScreen() : unAuthScreen();
  }
}
