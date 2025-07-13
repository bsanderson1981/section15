import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:section15/constants.dart';
import 'package:section15/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      if (userCredential != null) {
                        print("✅ Login successful! User ID: ${userCredential.user?.uid}");
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('🚨 No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('🚨 Wrong password provided for that user.');
                      } else {
                        print('🚨 Auth error: ${e.message}');
                      }
                    } catch (e) {
                      print('🚨 General error: $e');
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text('Log In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
