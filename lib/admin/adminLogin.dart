import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bloodbank_list.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bloodbanks()));
      }
    });
  }



  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  void signin() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } catch (e) {
        showError(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bld.jpg"), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text('LOGIN AS ADMINISTRATOR'),
                          Icon(
                            Icons.admin_panel_settings_sharp,
                            size: 100,
                          )
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Provide an email';
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue,
                                  focusColor: Colors.blue,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'E-mail'),
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          // Password TextField
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              validator: (input) {
                                if (input.length < 6) {
                                  return 'Password must be atleast 6 char long';
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue,
                                  focusColor: Colors.blue,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Password'),
                              onSaved: (input) => _password = input,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),

                          //  Sign In button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(30),
                                ),
                              ),
                              onPressed: signin,
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
