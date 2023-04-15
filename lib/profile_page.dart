import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_chat_app/side_drawer.dart';
import 'package:the_chat_app/welcome_screen.dart';

import 'components/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
          /*drawer: Drawer(
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
                      child: ListTile(
                        title: const Text(
                          'My Profile',
                          style: kTextStyle,
                        ),
                        onTap: (){
                          auth.signOut();
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
          ),*/
          drawer: MyDrawer(),
          backgroundColor: darkTheme == false ? kLightBackgroundColor : kDarkBackgroundColor,
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: <Widget>[

            ],
            centerTitle: true,
            title: const Text('My Profile'),
            backgroundColor: darkTheme == false ? kLightBackgroundColor.withOpacity(0.3) : Colors.blueGrey,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Text('Hi')
                ),
              ],
            ),
          ),
        )
    );
  }
}
