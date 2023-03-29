import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_chat_app/login_screen.dart';
import 'package:the_chat_app/registration_screen.dart';
import 'package:flutter/material.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';
import 'components/rounded_buttons.dart';
import 'components/constants.dart';
import 'layouts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    loadData();
    controller = AnimationController(vsync:this, duration: const Duration(seconds: 1),);

    animation = darkTheme == false ? ColorTween(begin: Colors.blueGrey, end: kLightBackgroundColor).animate(controller) :
    ColorTween(begin: kLightBackgroundColor, end:Colors.blueGrey,).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() { });
    });
  }

  loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkTheme = prefs.getBool('darkTheme')!;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: darkTheme == false ? kLightBackgroundColor : kDarkBackgroundColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Hero(
                            tag: 'logo',
                            child: Container(
                              child: Image.asset('images/the-chat-app-transparent.png'),
                              height: 250,
                              //height: animation.value * 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                    RoundedButton(
                      colour:kLightBlueAccent,
                      title:'Login',
                      onPress:(){
                        Navigator.pushNamed(context, LoginScreen.id);
                      }
                    ),
                    RoundedButton(
                      colour:kBlueAccent,
                      title:'Register',
                      onPress:(){
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      }
                    ),
                  ],
                ),
              ),
            )
          );
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: animation.value,
            //backgroundColor: kWhiteColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Container(
                            child: Image.asset('images/the-chat-app-transparent.png'),
                            height: 250,
                            //height: animation.value * 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  RoundedButton(
                    colour:kLightBlueAccent,
                    title:'Login',
                    onPress:(){
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                  ),
                  RoundedButton(
                    colour:kBlueAccent,
                    title:'Register',
                    onPress:(){
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    }
                  ),
                ],
              ),
            ),
          )
        );
      }
    );
  }
}

SomethingWentWrong(){
  print('Something went wrong');
}
