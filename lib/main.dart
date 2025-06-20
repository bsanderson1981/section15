import 'package:flutter/material.dart';
import 'package:section15/screens/welcome_screen.dart';
import 'package:section15/screens/login_screen.dart';
import 'package:section15/screens//registration_screen.dart';
import 'package:section15/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),

      // add below line to beginning of screen:     class WelcomeScreen extends StatefulWidget {
      //   static String id = 'welcome_screen';  //ad in screen navigation main.dart routes
      initialRoute:  WelcomeScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) =>  ChatScreen(),
        LoginScreen.id: (context) =>  LoginScreen(),
        RegistrationScreen.id: (context) =>  RegistrationScreen(),
      },
    );
  }
}
