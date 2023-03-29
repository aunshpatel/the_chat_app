import 'package:firebase_core/firebase_core.dart';
import 'package:the_chat_app/chat_screen.dart';
import 'package:flutter/material.dart';
import 'layouts.dart';
import 'components/constants.dart';
import 'components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
            backgroundColor: Color(0XFF97978D),
            body: ModalProgressHUD(
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
                            email = value;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: emailInputDecoration('Enter your email'),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        
                        /*TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          onChanged:(value){
                            pwd = value;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: emailInputDecoration('Enter your password'),
                        )*/

                        TextField(
                          controller: passwordController,
                          obscureText: _passwordVisible == false ? true : false,
                          onChanged:(value){
                            pwd = value;
                          },
                          style: const TextStyle(color: Colors.white),
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
                          //decoration: emailInputDecoration('Enter your password'),),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 1.0, color: Colors.white),
                              ),
                              fillColor: MaterialStateProperty.all(Colors.transparent),
                              value: _isChecked,
                              onChanged: (value){
                                _isChecked = !_isChecked;
                                print('_isChecked:$_isChecked');
                                _handleRememberMe(_isChecked);
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                color: Colors.white,
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
                              if(email != '' && pwd != '') {
                                if(pwd.length < 6){
                                  _showMyDialog('Incorrect password! Please check your password and try again.');
                                }
                                else{
                                  //final user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try{
                                    final user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
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
                                  }catch(e){
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    return _showMyDialog('${e.toString()}');
                                    //print('Error:$e');
                                  }
                                }
                              }
                              else if(pwd.isEmpty && email.isNotEmpty){
                                _showMyDialog('No password entered. Please enter the your password.');
                              }
                              else if(pwd.isNotEmpty && email.isEmpty){
                                _showMyDialog('No email id entered. Please enter your email id.');
                              }
                              else if(email.isEmpty && pwd.isEmpty){
                                _showMyDialog('Email and password fields are empty. Please enter both values to login.');
                              }
                              else if(email == '' && pwd != ''){
                                _showMyDialog('Please enter your email id to login.');
                              }
                              else if(email == '' && pwd != ''){
                                _showMyDialog('Please enter your password to login.');
                              }
                          },
                        ),
                      ],
                    ),
                  ),
              ),
            )
        )
    );
  }

  //Code for 'Remember Me' Functionality
  void _handleRememberMe(bool value) {
    print('Handle Rember Me');
    _isChecked = value;
    if(_isChecked == true){
      SharedPreferences.getInstance().then(
            (prefs) {
          prefs.setBool('remember_me', _isChecked);
          prefs.setString('email', emailController.text);
          prefs.setString('password', passwordController.text);
        },
      );
    }
    else{
      SharedPreferences.getInstance().then(
            (prefs) {
              emailController.text = '';
              passwordController.text = '';
          prefs.setBool('remember_me', false);
          prefs.setString('email', '');
          prefs.setString('password', '');
        },
      );
    }
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print('Load Email');
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString('email') ?? '';
      var _password = _prefs.getString('password') ?? '';
      var _rememberMe = _prefs.getBool('remember_me') ?? false;

      print('_rememberMe:$_rememberMe');
      print('_email:$_email');
      print('_password:$_password');
      if (_rememberMe == true) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email ?? '';
        passwordController.text = _password ?? '';
      }
      else{
        setState(() {
          _isChecked = false;
        });
        emailController.text = '';
        passwordController.text = '';
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
