import 'package:firebase_core/firebase_core.dart';
import 'package:the_chat_app/chat_screen.dart';
import 'package:flutter/material.dart';
import 'layouts.dart';
import 'components/constants.dart';
import 'components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', pwd = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
            backgroundColor: Color(0XFF97978D),
            //backgroundColor: Colors.white,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                /*child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),
                        const SizedBox(
                          height: 48.0,
                        ),
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
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                if(user != null){
                                  Navigator.pushNamed(context, ChatScreen.id);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                                else{
                                  print('Hi');
                                }
                              }catch(e){
                                print('Error:$e');
                              }
                            }
                        ),
                      ],
                    ),
                  )
                )*/
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(child: HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),),
                        const SizedBox(
                          height: 48.0,
                        ),
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
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                if(user != null){
                                  Navigator.pushNamed(context, ChatScreen.id);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                                else{
                                  print('Hi');
                                }
                              }catch(e){
                                print('Error:$e');
                              }
                            }
                        ),
                      ],
                    ),
                  ),
              ),
            )
        )
    );
  }
}
