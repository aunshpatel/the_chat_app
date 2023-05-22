import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

bool darkTheme = false;

late User loggedInUser;

String loginEmailID = '';

String loginPassword = '';

var kDarkBackgroundColor = Colors.blueGrey.shade800;

var kLightBackgroundColor = Color(0XFF97978D);

const kWhiteColor = Colors.white;

const kBlackColor = Colors.black;

const kBlack54Color = Colors.black54;

const kLightBlue = Colors.lightBlue;

const kLightGreen = Colors.lightGreen;

const kGray = Color(0XFF808080);

const kLightBlueAccent = Colors.lightBlueAccent;

const kBlueAccent = Colors.blueAccent;

var kSendButtonTextStyle = TextStyle(
  color: kLightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: kWhiteColor),
  border: InputBorder.none,
);

InputDecoration emailInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: kWhiteColor),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
  );
}

InputDecoration passwordInputDecoration(String hintText, bool _passwordVisible, void toggle()){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: kWhiteColor),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
    suffixIcon: IconButton(
      icon: Icon(
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: kLightBlueAccent,
      ),
      onPressed: toggle,
    ),
  );
}


var kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: darkTheme == false ? const BorderSide(color: kLightBlueAccent, width: 2.0) : const BorderSide(color: Colors.blueGrey, width: 2.0,),
    left: darkTheme == false ? const BorderSide(color: kLightBlueAccent, width: 2.0) : const BorderSide(color: Colors.blueGrey, width: 2.0),
    right: darkTheme == false ? const BorderSide(color: kLightBlueAccent, width: 2.0) : const BorderSide(color: Colors.blueGrey, width: 2.0),
    bottom: darkTheme == false ? const BorderSide(color: kLightBlueAccent, width: 2.0) : const BorderSide(color: Colors.blueGrey, width: 2.0),
  ),
);

var kDisabledInputFieldDecoration = const BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0XFF787878), width: 2.0,),
    left: BorderSide(color: Color(0XFF787878), width: 2.0),
    right: BorderSide(color: Color(0XFF787878), width: 2.0),
    bottom: BorderSide(color: Color(0XFF787878), width: 2.0),
  ),
);

const kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kLightBlueAccent, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

var kFocusedBorder = OutlineInputBorder(
  borderSide: darkTheme == false ?  BorderSide(color: kBlueAccent, width: 2.0) : BorderSide(color: Colors.blueGrey, width: 2.0),
  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
);

var kBottomBorder = BoxDecoration(
    border: Border(
        bottom: BorderSide(
          color: darkTheme == false ? kWhiteColor : Colors.blueGrey,
        )
    )
);

const kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kWhiteColor,
);