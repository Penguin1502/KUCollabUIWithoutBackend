/* All commented packages are backend-related. */

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

//final _firestore = FirebaseFirestore.instance;    Creates a new Firebase instance to be used
//User loggedInUser;    Creates a new User in the new version. 

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController(); //This is for clearing the textfield later on. It's just initializing the controller object for now
  //final _auth = FirebaseAuth.instance;    Firebase authenticator instance initialized

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser(); //Called when starting up this file
  }

  void getCurrentUser() async {
   // try {
    //  final user = await _auth.currentUser; //Gets current user from authenticator
     // if (user != null) {
    //    loggedInUser = user; //if authenticator says there's someone logged in it sets to loggedinUser
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close), //close button
              onPressed: () {
               // _auth.signOut(); //tells authenticator object to sign out user 
                Navigator.pop(context); //then pops current instance off the app stack 
              }),
        ],
        title: Text('Chat Page'),
        backgroundColor: Color(0xFF990000), //This is KU color scheme
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),     //This is backend portion. The main part of the screen where all the text bubbles are
            Container(          //Bottom part containing text field and send button
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                    //  controller: messageTextController,    This was used to clear field
                      onChanged: (value) {
                    //    messageText = value; //when u press the button next to it whatever value is in message Text will be sent
                      },
                      decoration: kMessageTextFieldDecoration, //Uses another file called constants.dart to get styling elements for text field
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                   //   messageTextController.clear();
                   //   _firestore.collection('messages').add({       //Add to firestore collection under messages collection a new object
                   //     'text': messageText,
                    //    'sender': loggedInUser.email,
                      },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,    //Styled element
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

class MessagesStream extends StatelessWidget {      //Hardest part of the app - stream builder page where bubbles are displayed
  @override
  Widget build(BuildContext context) {
    //return StreamBuilder<QuerySnapshot>(        //returns future objects as a stream builder
    //  stream: _firestore.collection('messages').snapshots(),      //source of stream items is messages collection
//      builder: (context, snapshot) {      
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(       //loading circle in case it doesn't have data yet
//              backgroundColor: Colors.lightBlueAccent,
//            ),
//          );
//        }
//        final messages = snapshot.data.docs.reversed;     //once it gets the data, the snapshot of the messages collection is reversed. Then this is parsed through bottom to top so that the latest text history comes first
//        List<MessageBubble> messageBubbles = [];      //new list of type Message Bubble
//
//        for (var message in messages) {
//          final messageText = message['text'];      //go within a single item in the messages collection and search for text and sender in its properties
//          final messageSender = message['sender'];
//
////          final currentUser = loggedInUser.email;     //the authenticated user's email can be gotten from authenticator object
//
//
//          final messageBubble = MessageBubble(      //build a item of type Message Bubble to put into the list we made earlier. Message Bubbles list 
//            sender: messageSender,
//            text: messageText,
//            isMe: loggedInUser == messageSender,
//          );
//
//          messageBubbles.add(messageBubble);
//        }
//
//        return Expanded(
//          child: ListView(
//            reverse: true,
//            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//            children: messageBubbles,       //that list is put here
//          ),
//        );
//      },
//    );
  }
}

class MessageBubble extends StatelessWidget {       //custom class for message bubbles
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,     //Alignment set to end if its you sending the messages, otherwise front
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xFF990000) : Colors.white,     //if its you its red if its not its white
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,      //white or black text depending on who it is
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
