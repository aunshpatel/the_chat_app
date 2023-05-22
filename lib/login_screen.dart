import 'package:firebase_core/firebase_core.dart';
import 'package:the_chat_app/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/welcome_screen.dart';
import 'layouts.dart';
import 'components/constants.dart';
import 'components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _passwordVisible = false;
  bool _isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged:(value){
                            email = emailController.text;
                          },
                          style: const TextStyle(color: kWhiteColor),
                          decoration: emailInputDecoration('Enter your email'),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: _passwordVisible == false ? true : false,
                          onChanged:(value){
                            pwd = passwordController.text;
                          },
                          style: const TextStyle(color: kWhiteColor),
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
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: kWhiteColor,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(width: 1.0, color: kWhiteColor),
                              ),
                              fillColor: MaterialStateProperty.all(Colors.transparent),
                              value: _isChecked,
                              onChanged: (value){
                                _isChecked = !_isChecked!;
                                actionRemeberMe(_isChecked);
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        RoundedButton(
                          colour:kLightBlueAccent,
                          title:'Login',
                          onPress:() async {
                            if(emailController.text != '' && passwordController.text != '') {
                              if(emailController.text.length < 6){
                                _showMyDialog('Incorrect password! Please check your password length and try again.');
                              }
                              else{
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final user = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                  if(user != null){
                                    Navigator.pushNamed(context, ChatScreen.id);
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                  else{
                                    _showMyDialog('Incorrect email or password. Please enter your email and password again.');
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                } catch(e){
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  return _showMyDialog('${e.toString()}');
                                }
                              }
                            }
                            else if(passwordController.text.isEmpty && emailController.text.isNotEmpty){
                              _showMyDialog('No password entered. Please enter the your password.');
                            }
                            else if(passwordController.text.isNotEmpty && emailController.text.isEmpty){
                              _showMyDialog('No email id entered. Please enter your email id.');
                            }
                            else if(emailController.text.isEmpty && passwordController.text.isEmpty){
                              _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                            }
                            else if(emailController.text == '' && passwordController.text != ''){
                              _showMyDialog('Please enter your email id to login.');
                            }
                            else if(emailController.text == '' && passwordController.text != ''){
                              _showMyDialog('Please enter your password to login.');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ),
            )*/
          appBar: appBarDetails,
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(child: HeroLogo(tag:'logo',height: 250.0, image: 'images/the-chat-app-transparent.png'),),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged:(value){
                      email = emailController.text;
                    },
                    style: const TextStyle(color: kWhiteColor),
                    decoration: emailInputDecoration('Enter your email'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: _passwordVisible == false ? true : false,
                    onChanged:(value){
                      pwd = passwordController.text;
                    },
                    style: const TextStyle(color: kWhiteColor),
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
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: kWhiteColor,
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(width: 1.0, color: kWhiteColor),
                        ),
                        fillColor: MaterialStateProperty.all(Colors.transparent),
                        value: _isChecked,
                        onChanged: (value){
                          _isChecked = !_isChecked!;
                          actionRemeberMe(_isChecked);
                        },
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    colour:kLightBlueAccent,
                    title:'Login',
                    onPress:() async {
                      if(emailController.text != '' && passwordController.text != '') {
                        if(emailController.text.length < 6){
                          _showMyDialog('Incorrect password! Please check your password length and try again.');
                        }
                        else{
                          setState(() {
                            showSpinner = true;
                          });
                          try{
                            final user = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                            if(user != null){
                              Navigator.pushNamed(context, ChatScreen.id);
                              setState(() {
                                showSpinner = false;
                              });
                            }
                            else{
                              _showMyDialog('Incorrect email or password. Please enter your email and password again.');
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch(e){
                            setState(() {
                              showSpinner = false;
                            });
                            return _showMyDialog('${e.toString()}');
                          }
                        }
                      }
                      else if(passwordController.text.isEmpty && emailController.text.isNotEmpty){
                        _showMyDialog('No password entered. Please enter the your password.');
                      }
                      else if(passwordController.text.isNotEmpty && emailController.text.isEmpty){
                        _showMyDialog('No email id entered. Please enter your email id.');
                      }
                      else if(emailController.text.isEmpty && passwordController.text.isEmpty){
                        _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                      }
                      else if(emailController.text == '' && passwordController.text != ''){
                        _showMyDialog('Please enter your email id to login.');
                      }
                      else if(emailController.text == '' && passwordController.text != ''){
                        _showMyDialog('Please enter your password to login.');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  actionRemeberMe(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then((prefs) {
        prefs.setBool("remember_me", _isChecked);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print('Load Email');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginEmailID = prefs.getString('email') ?? '';
      loginPassword = prefs.getString('password') ?? '';

      var rememberMe = prefs.getBool('remember_me') ?? false;

      print('rememberMe:$rememberMe');
      print('emailID:$loginEmailID');
      print('password:$loginPassword');
      if (rememberMe == true) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = loginEmailID;
        passwordController.text = loginPassword;
      }
      else{
        setState(() {
          _isChecked = false;
        });
        emailController.text = '';
        loginEmailID = '';
        passwordController.text = '';
        loginPassword = '';
      }
    } catch (e) {
      print(e);
    }
  }

  //Alert box
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
