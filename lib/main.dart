import 'package:the_chat_app/registration_screen.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),*/
      //home: WelcomeScreen(),
      //initialRoute: '/',
      initialRoute: WelcomeScreen.id,
      routes: {
        /*'/': (context) => WelcomeScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/registrationScreen': (context) => RegistrationScreen(),
        '/chatScreen': (context) => ChatScreen(),*/
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),
      },
    );
  }
}