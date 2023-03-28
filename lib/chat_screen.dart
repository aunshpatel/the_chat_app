import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textMessageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: kMessageTextFieldDecoration,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        _firestore.collection('messages').add({'message':messageText, 'sender':loggedInUser.email});
                        textMessageController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data?.docs;
        print('messages:$messages');
        List<MessageBubble> messageBubbles = [];
        for(var message in messages!){
          final messageText = message.get('message'), messageSender = message.get('sender');
          final messageBubble = MessageBubble(messageSender, messageText);
          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                SizedBox(
                  width:MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:messageBubbles,
                  ),
                )
              ],
            )
        );
        /*else if(snapshot.hasData){
                  final messages = snapshot.data?.docs;
                  print('messages:$messages');
                  List<Text> messageBubbles = [];
                  for(var message in messages!){
                    final messageText = message.get('message');
                    final messageSender = message.get('sender');
                    final messageBubble = Text('$messageText from $messageSender');
                    messageBubbles.add(messageBubble);
                  }
                  return Column(
                    children:messageBubbles,
                  );
                }*/
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble(this.sender, this.text);
  final String text, sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 2.0,),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                //'$text from $sender',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
