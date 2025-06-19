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
      home: WelcomeScreen(),
    );
  }
}
