import 'package:flutter/material.dart';
import 'package:section15/screens/welcome_screen.dart';
import 'package:section15/screens/login_screen.dart';
import 'package:section15/screens//registration_screen.dart';
import 'package:section15/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';


/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();// not ensureInigizlied
  runApp(FlashChat());
}*/
//test4
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 print('✅ Firebase initialized');
  runApp(FlashChat());
}
//test

//tes4
class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

//test2
  //test3
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


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
