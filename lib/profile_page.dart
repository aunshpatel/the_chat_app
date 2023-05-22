import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_chat_app/side_drawer.dart';
import 'components/constants.dart';

TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
String registeredEmailID = '';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int _value = 0;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    final user = auth.currentUser;
    if(user!=null){
      emailController.text = user.email.toString();
      registeredEmailID = user.email.toString();
    }
    if(darkTheme == true){
      _value = 1;
    }
    else{
      _value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkTheme == false ? kLightBackgroundColor : kDarkBackgroundColor,
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
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: CurrentUserDetails(),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Application Theme:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    SizedBox(
                      width: 70.0,
                      child: DropdownButton(
                        value: _value,
                        dropdownColor: darkTheme == false ? kLightBackgroundColor: Colors.blueGrey,
                        items: const <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            child: Text(
                              'Light',
                              style: kTextStyle,
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Dark',
                              style: kTextStyle,
                            ),
                            value: 1,
                          ),
                        ],
                        onChanged: (int? value) async{
                          setState(() {
                            _value = value!;
                            if(value == 0){
                              darkTheme = false;
                            }
                            else if(value == 1){
                              darkTheme = true;
                            }
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setBool("darkTheme", darkTheme);
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}

class CurrentUserDetails extends StatelessWidget {
  late bool isContactListEmpty = true;
  @override

  Widget build(BuildContext context) {
    nameController.text = loggedInUser.displayName.toString();
    emailController.text = loggedInUser.email.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Name:',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 5.0,),
        Container(
            height:50,
            decoration: kDisabledInputFieldDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: kWhiteColor,fontSize: 18),
                    decoration: const InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      hintStyle: TextStyle(color: kWhiteColor),
                      border: InputBorder.none,
                    ),
                    onChanged: null,
                  ),
                ),
              ],
            )
        ),
        const SizedBox(height: 20,),
        const Text(
          'Email ID:',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 5.0,),
        Container(
            height:50,
            decoration: kDisabledInputFieldDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: kWhiteColor,fontSize: 18),
                    decoration: const InputDecoration(
                      enabled: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      hintStyle: TextStyle(color: kWhiteColor),
                      border: InputBorder.none,
                    ),
                    onChanged: null,
                  ),
                ),
              ],
            )
        ),
      ],
    );

    /*return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('registeredUsers').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              if(data['emailID'].toString() == loggedInUser.email.toString()){
                nameController.text = data['fullName'].toString();
                emailController.text = data['emailID'].toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                        height:50,
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: nameController,
                                style: const TextStyle(color: kWhiteColor),
                                decoration: const InputDecoration(
                                  enabled: false,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  //hintText: 'Type your message here...',
                                  hintStyle: TextStyle(color: kWhiteColor),
                                  border: InputBorder.none,
                                ),
                                onChanged: null,
                              ),
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Email ID:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                        height:50,
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                style: const TextStyle(color: kWhiteColor),
                                decoration: const InputDecoration(
                                  enabled: false,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  //hintText: 'Type your message here...',
                                  hintStyle: TextStyle(color: kWhiteColor),
                                  border: InputBorder.none,
                                ),
                                onChanged: null,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                );
              }
              else{
                return SizedBox(height:0);
              }
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );*/
  }
}


/*class CurrentUserDetails extends StatelessWidget {
  late bool isContactListEmpty = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('registeredUsers').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              if(data['emailID'].toString() == loggedInUser.email.toString()){
                nameController.text = data['fullName'].toString();
                emailController.text = data['emailID'].toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                      height:50,
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              style: const TextStyle(color: kWhiteColor),
                              decoration: const InputDecoration(
                                enabled: false,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                //hintText: 'Type your message here...',
                                hintStyle: TextStyle(color: kWhiteColor),
                                border: InputBorder.none,
                              ),
                              onChanged: null,
                            ),
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Email ID:',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Container(
                      height:50,
                      decoration: kMessageContainerDecoration,
                      child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                style: const TextStyle(color: kWhiteColor),
                                decoration: const InputDecoration(
                                  enabled: false,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  //hintText: 'Type your message here...',
                                  hintStyle: TextStyle(color: kWhiteColor),
                                  border: InputBorder.none,
                                ),
                                onChanged: null,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                );
              }
              else{
                return SizedBox(height:0);
              }
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}*/
