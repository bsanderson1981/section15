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
  final messageTextController = TextEditingController();

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
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index].data() as Map<String, dynamic>;

                      return Align(
                        alignment: Alignment.centerRight, // 👈 Right-justify whole bubble
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6), // space between bubbles
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end, // 👈 Right-align sender + message
                              children: [
                                Text(
                                  msg['sender'] ?? 'Unknown Sender',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Material(
                                  elevation: 6.0, // 👈 adds the shadow
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.lightBlue, // 👈 background color of bubble
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    child: Text(
                                      msg['text'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
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
