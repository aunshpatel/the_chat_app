import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'components/rounded_buttons.dart';
import 'components/constants.dart';
import 'layouts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailID = '', pwd = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0XFF97978D),
          //backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height-100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),
                          const SizedBox(
                            height: 48.0,
                          ),
                          TextField(
                            onChanged:(value){
                              emailID = value;
                            },
                            keyboardType: TextInputType.emailAddress,
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
                            style: TextStyle(color: Colors.white),
                            decoration: buildInputDecoration('Enter your password'),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          RoundedButton(
                              colour:kBlueAccent,
                              title:'Register',
                              onPress:() async{
                                print('Email:$emailID, password:$pwd');
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final newUser = await _auth.createUserWithEmailAndPassword(email: emailID, password: pwd);
                                  if(newUser != null){
                                    Navigator.pushNamed(context, ChatScreen.id);
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                }
                                catch(e){
                                  print(e);
                                }
                              }
                          ),
                        ],
                      ),
                    )
                )
            ),
          )
        )
    );
  }
}
