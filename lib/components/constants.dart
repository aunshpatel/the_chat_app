import 'package:flutter/material.dart';

const kLightBlueAccent = Colors.lightBlueAccent;

const kBlueAccent = Colors.blueAccent;

const kSendButtonTextStyle = TextStyle(
  color: kLightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.white),
  border: InputBorder.none,
);

InputDecoration emailInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
  );
}

InputDecoration passwordInputDecoration(String hintText, bool _passwordVisible, void toggle()){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kEnabledBorder,
    focusedBorder: kFocusedBorder,
    suffixIcon: IconButton(
      icon: Icon(
        // Based on passwordVisible state choose the icon
        _passwordVisible
            ? Icons.visibility
            : Icons.visibility_off,
        color: kLightBlueAccent,
      ),
      onPressed: toggle,
    ),
  );
}


const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kLightBlueAccent, width: 2.0),
    left: BorderSide(color: kLightBlueAccent, width: 2.0),
    right: BorderSide(color: kLightBlueAccent, width: 2.0),
    bottom: BorderSide(color: kLightBlueAccent, width: 2.0),
  ),
);

const kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kLightBlueAccent, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kBlueAccent, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kBottomBorder = BoxDecoration(
    border: Border(
        bottom: BorderSide(
          color: Colors.white,
        )
    )
);

const kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.white,
);