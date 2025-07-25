import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:section15/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';   //ad in screen navigation main.dart routes
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
 late String  messageText;
  User? loggedInUser; //was FirebaseUser depricaated V1 firebase

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser () async {
    try{
    final user = await _auth.currentUser;  // was final user = _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
      // you can safely use `user`
      print(user.email);
    }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
  await for ( var snapshot  in _firestore.collection('messages').snapshots()) {
    print('start stream listen');
    for (var message in snapshot.docs){
      print(message.data());  // had to modify this from course code  needed to call funtions () was  >   print(message.data);
     }

  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                //_auth.signOut();
               // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                       _firestore.collection('messages').add({
                         'text': messageText,
                         'sender': loggedInUser?.email,
                       });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
