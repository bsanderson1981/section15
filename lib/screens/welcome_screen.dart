
//import 'dart:io';

import 'package:flutter/material.dart';

import 'package:section15/components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';  //ad in screen navigation main.dart routes
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin { //mix in needed for vsync

 //animate start
  late AnimationController controller;
  late Animation animation;
  @override  // need state to change animation
  void initState(){
    super.initState();

   controller =  AnimationController(  //constructor
     duration: Duration(seconds: 1),
      vsync: this, upperBound: 1.0
   );
/*    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);*/
      animation = ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);
      controller.forward();
     /* animation.addStatusListener((status){
        if (status == AnimationStatus.completed){
          controller.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed){
          controller.forward();
        }

        print(status);
      });*/

      controller.addListener((){
        setState(() {
        // this setState is required to animate the red color shift
        // backgroundColor: Colors.red.withAlpha((controller.value * 255).toInt()),
          // in section 15 lesson 174
        });
        print(animation.value);
      }
      );
  }
  // dispose of animation controller to not allow to
  //run forever when not needed
  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      //backgroundColor: Colors.red.withAlpha((controller.value * 255).toInt()),
      //withOpacity is depricated
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60, // need *100 to see curve
                  ),
                ),
                Text(
                  // had to add * 100 to get correct number count up 1 100%
                  //'${(controller.value * 100).toInt()}%',
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
          RoundedButton(
            title: 'Log In',
            color: Colors.lightBlueAccent,
              onPressed: (){
                   Navigator.pushNamed(context, LoginScreen.id);
                },
            ),


            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
                  ),
          ],
        ),
      ),
    );
  }
}

