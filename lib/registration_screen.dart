import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'components/rounded_buttons.dart';
import 'components/constants.dart';
import 'layouts.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _registrationSctreenFirestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailID = '', pwd = '', fullName = '', confirmationPwd = '';
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkTheme == false ? kLightBackgroundColor : kDarkBackgroundColor,
          /*body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                        fullName = value;
                      },
                      style: const TextStyle(color: kWhiteColor),
                      decoration: emailInputDecoration('Enter your full name.'),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      onChanged:(value){
                        emailID = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: kWhiteColor),
                      decoration: emailInputDecoration('Enter your email'),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      obscureText: _passwordVisible == false ? true : false,
                      onChanged:(value){
                        pwd = value;
                      },
                      style: TextStyle(color: kWhiteColor),
                      decoration: passwordInputDecoration(
                        'Enter your password',
                        _passwordVisible,
                        (){
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      obscureText: _confirmPasswordVisible == false ? true : false,
                      onChanged:(value){
                        confirmationPwd = value;
                      },
                      style: TextStyle(color: kWhiteColor),
                      decoration: passwordInputDecoration(
                        'Confirm your password',
                        _confirmPasswordVisible,
                        (){
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        }
                      ),
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
                            setState(() {
                              showSpinner = false;
                            });
                            _showMyDialog('Please at least 6 characters for your password.');
                          }
                          else{
                            if(confirmationPwd == pwd){
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                final newUser = await _auth.createUserWithEmailAndPassword(email: emailID, password: pwd);
                                if(newUser != null){
                                  _registrationSctreenFirestore.collection('registeredUsers').add({'fullName':fullName, 'emailID':emailID,});
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
                                }
                              } catch(e){
                                setState(() {
                                  showSpinner = false;
                                });
                                return _showMyDialog('${e.toString()}');
                              }
                            }
                            else {
                              _showMyDialog('Your passwords are not same. Please check and enter again.');
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
                      }
                    ),
                  ],
                ),
              ),
            ),
          )*/
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    fullName = value;
                  },
                  style: const TextStyle(color: kWhiteColor),
                  decoration: emailInputDecoration('Enter your full name.'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  onChanged:(value){
                    emailID = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: kWhiteColor),
                  decoration: emailInputDecoration('Enter your email'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  obscureText: _passwordVisible == false ? true : false,
                  onChanged:(value){
                    pwd = value;
                  },
                  style: TextStyle(color: kWhiteColor),
                  decoration: passwordInputDecoration(
                      'Enter your password',
                      _passwordVisible,
                          (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      }
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  obscureText: _confirmPasswordVisible == false ? true : false,
                  onChanged:(value){
                    confirmationPwd = value;
                  },
                  style: TextStyle(color: kWhiteColor),
                  decoration: passwordInputDecoration(
                      'Confirm your password',
                      _confirmPasswordVisible,
                          (){
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      }
                  ),
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
                          setState(() {
                            showSpinner = false;
                          });
                          _showMyDialog('Please at least 6 characters for your password.');
                        }
                        else{
                          if(confirmationPwd == pwd){
                            setState(() {
                              showSpinner = true;
                            });
                            try{
                              final newUser = await _auth.createUserWithEmailAndPassword(email: emailID, password: pwd);
                              if(newUser != null){
                                _registrationSctreenFirestore.collection('registeredUsers').add({'fullName':fullName, 'emailID':emailID,});
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
                              }
                            } catch(e){
                              setState(() {
                                showSpinner = false;
                              });
                              return _showMyDialog('${e.toString()}');
                            }
                          }
                          else {
                            _showMyDialog('Your passwords are not same. Please check and enter again.');
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
                    }
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Future<void> _showMyDialog(String text) async {
    String AlertText = text;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AlertText),
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
