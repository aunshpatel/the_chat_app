import 'package:flutter/material.dart';

import 'package:the_chat_app/main_menu_page.dart';
import 'package:the_chat_app/profile_page.dart';
import 'package:the_chat_app/registration_screen.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        ProfilePage.id : (context) => ProfilePage(),
        MainMenuPage.id : (context) => MainMenuPage(),
      },
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: WelcomeScreen.id,
//       routes: {
//         WelcomeScreen.id : (context) => WelcomeScreen(),
//         LoginScreen.id : (context) => LoginScreen(),
//         RegistrationScreen.id : (context) => RegistrationScreen(),
//         ChatScreen.id : (context) => ChatScreen(),
//         ProfilePage.id : (context) => ProfilePage(),
//         MainMenuPage.id : (context) => MainMenuPage(),
//       },
//     );
//   }
// }