import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String messageText = '';
  TextEditingController textMessageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    messagesStream();
    //getMessages();
  }

  void getCurrentUser() async{
    final user = await _auth.currentUser;
    if(user!=null){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }

  // void getMessages() async{
  //   //final messages = await _firestore.collection('messages').get();
  //   final messages = await _firestore.collection('messages').get();
  //   final allData = messages.docs.map((doc) => doc.data()).toList();
  //
  //   for (var message in messages.docs){
  //     print('Message values: ${message.data().values}');
  //   }
  //   for (var message in allData){
  //     print('message.entries:${message.entries}');
  //     print('message.values:${message.values}');
  //   }
  // }

  void messagesStream() async{
     await for(var snapshot in _firestore.collection('messages').snapshots()){
       for (var message in snapshot.docs){
         print('first value:${message.data().values.first}, last value: ${message.data().values.last}');
       }
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF97978D),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
            }),
        ],
        centerTitle: true,
        title: Text('The Chat App'),
        backgroundColor: kLightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final messages = snapshot.data?.docs;
                  print('messages:$messages');
                  List<Text> messageWigets = [];
                  for(var message in messages!){
                    final messageText = message.get('message');
                    final messageSender = message.get('sender');
                    final messageWiget = Text('$messageText from $messageSender');
                    messageWigets.add(messageWiget);
                  }
                  return Column(
                    children:messageWigets,
                  );
                }
                else{
                  print('No data found');
                  return SizedBox(
                    child: Text('Snapshot has no data'),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textMessageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      _firestore.collection('messages').add({'message':messageText, 'sender':loggedInUser.email});
                      textMessageController.clear();
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
