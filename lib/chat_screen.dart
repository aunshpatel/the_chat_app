import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String messageText = '';
  TextEditingController textMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //messagesStream();
  }

  void getCurrentUser() async{
    final user = await _auth.currentUser;
    if(user!=null){
      loggedInUser = user;
    }
  }

  // void messagesStream() async{
  //    await for(var snapshot in _firestore.collection('messages').snapshots()){
  //      for (var message in snapshot.docs){
  //        //print('first value:${message.data().values.first}, last value: ${message.data().values.last}');
  //      }
  //    }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawerEnableOpenDragGesture: false,
        drawer: Drawer(
            backgroundColor: Color(0XFF97978D),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [

                  Container(
                    decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.white
                        )
                    )
                    ),
                    child: ListTile(
                      title: const Text(
                        'Change Theme',
                        style: kTextStyle,
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white
                        )
                      )
                    ),
                    child: ListTile(
                      title: const Text(
                        'Logout',
                        style: kTextStyle,
                      ),
                      onTap: (){
                        _auth.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
        backgroundColor: Color(0XFF97978D),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            /*IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),*/
          ],
          centerTitle: true,
          title: Text('The Chat App'),
          backgroundColor: kLightBlueAccent,
        ),
        body: Padding(
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
        ),
      )
    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({Key? key}) : super(key: key);
  late bool isMessageBubblesEmpty = false;
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
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for(var message in messages!){
          final messageText = message.get('message');
          final messageSender = message.get('sender');
          final currentUser = loggedInUser.email;

          if(messageBubbles.isNotEmpty){
            isMessageBubblesEmpty = true;
          }
          else{
            isMessageBubblesEmpty = false;
          }

          final messageBubble = MessageBubble(messageSender, messageText, currentUser == messageSender ? true : false);

          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: isMessageBubblesEmpty == true?
            ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:messageBubbles,
                )
              ],
            ): SizedBox(
              height: MediaQuery.of(context).size.height - 250,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You do not have any active chats.\nPlease send a message to start chatting.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble(this.sender, this.text, this.isMe);

  final String text, sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: isMe == true ? CrossAxisAlignment.end:CrossAxisAlignment.start,
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
              borderRadius: isMe == true ? const BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)) :
              const BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
              color: isMe ==true? Colors.lightBlue : Colors.lightGreen,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}