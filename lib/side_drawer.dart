import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_chat_app/chat_screen.dart';
import 'package:the_chat_app/profile_page.dart';
import 'package:the_chat_app/welcome_screen.dart';

import 'components/constants.dart';

class MyDrawer extends StatefulWidget {
  //const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: darkTheme == false ? kLightBackgroundColor: Colors.blueGrey,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    )
                  )
                ),
                child: SizedBox(
                  height: 200,
                  child: Image.asset('images/the-chat-app-transparent.png')
                )
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    )
                  )
                ),
                child: ListTile(
                  title: const Text(
                    'Chat Screen',
                    style: kTextStyle,
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    )
                  )
                ),
                child: ListTile(
                  title: const Text(
                    'My Profile',
                    style: kTextStyle,
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, ProfilePage.id);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    )
                  )
                ),
                child: ListTile(
                  title: Text(
                    darkTheme == false ? 'Change To Dark Theme' : 'Change To Light Theme',
                    style: kTextStyle,
                  ),
                  onTap: () async{
                    setState(() {
                      darkTheme = !darkTheme;
                    });
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setBool("darkTheme", darkTheme);
                    },
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    )
                  )
                ),
                child: ListTile(
                  title: const Text(
                    'Logout',
                    style: kTextStyle,
                  ),
                  onTap: (){
                    auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
