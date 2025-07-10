import 'package:flutter/material.dart';
//import 'package:section15/screens/registration_screen.dart';
//import 'package:section15/screens/login_screen.dart';
class RoundedButton extends StatelessWidget {
  const RoundedButton({required this.title,  required this.color, required this.onPressed,});

  final String title;
  final VoidCallback onPressed;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),

        child:MaterialButton(
            onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
              style: TextStyle(
                color: Colors.white,
               //color: Colors.white ,
              ),

          ),
        ),
      ),
    );
  }
}
