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
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height-100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(child: HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),),
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
                          if(emailID != '' && pwd != ''){
                            if(pwd.length < 6){
                              _showMyDialog('Please atleast 6 digits for your password.');
                            }
                            else{
                              //final user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                final user = await _auth.signInWithEmailAndPassword(email: emailID, password: pwd);
                                if(user != null){
                                  Navigator.pushNamed(context, ChatScreen.id);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                                else{
                                  _showMyDialog('Incorrect email or password. Please enter your email and password again.');
                                }
                              }catch(e){
                                //_showMyDialog('${e.toString()}');
                                return _showMyDialog('${e.toString()}');
                                //print('Error:$e');
                              }
                            }
                          }
                          else if(pwd.isEmpty && emailID.isNotEmpty){
                            _showMyDialog('No password entered. Please enter the your password.');
                          }
                          else if(pwd.isNotEmpty && emailID.isEmpty){
                            _showMyDialog('No email id entered. Please enter your email id.');
                          }
                          else if(emailID.isEmpty && pwd.isEmpty){
                            _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                          }
                          else if(emailID == '' && pwd != ''){
                            _showMyDialog('Please enter your email id to login.');
                          }
                          else if(emailID == '' && pwd != ''){
                            _showMyDialog('Please enter your password to login.');
                          }
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
              ),
            ),
          )
        )
    );
  }

  Future<void> _showMyDialog(String text) async {
    String AlertText = text;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AlertText),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
