import 'package:firebase_core/firebase_core.dart';
import 'package:the_chat_app/chat_screen.dart';
import 'package:flutter/material.dart';
import 'layouts.dart';
import 'components/constants.dart';
import 'components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', pwd = '';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0XFF97978D),
          //backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),
                const SizedBox(
                  height: 48.0,
                ),
                /*LayoutTextField(
                  obscureText:false,
                  onChange:(value){},
                  hintText: 'Enter your email',
                ),*/

                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged:(value){
                    email = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: buildInputDecoration('Enter your email'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                /*LayoutTextField(
                  obscureText:true,
                  onChange:(value){},
                  hintText: 'Enter your pwd',
                ),*/

                TextField(
                  obscureText: true,
                  onChanged:(value){
                    pwd = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: buildInputDecoration('Enter your password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    colour:kLightBlueAccent,
                    title:'Login',
                    onPress:() async {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
                      //print(user);
                      try{
                        if(user !=null){
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        else{
                          print('Hi');
                        }
                      }catch(e){
                        print('Error:$e');
                      }
                      //Navigator.pushNamed(context, ChatScreen.id);

                    }
                ),
              ],
            ),
          ),
        )
    );
  }
}
