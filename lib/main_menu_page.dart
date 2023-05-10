import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/side_drawer.dart';

import 'chat_screen.dart';
import 'components/constants.dart';
final _firestore = FirebaseFirestore.instance;

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);
  static const String id = 'main_menu_page';

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkTheme == false ? kLightBackgroundColor : kDarkBackgroundColor,
        endDrawerEnableOpenDragGesture: false,
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
          title: const Text('The Chat App'),
          backgroundColor: darkTheme == false ? kLightBackgroundColor.withOpacity(0.3) : Colors.blueGrey,
        ),
        body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ContactList(),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ContactList extends StatelessWidget {
  late bool isContactListEmpty = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('registeredUsers').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          print('Docs: $docs');
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkTheme == false ? kWhiteColor : kBlackColor,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    data['fullName'],
                    style: kTextStyle,
                  ),
                  subtitle: Text(
                    data['emailID'],
                    style: kTextStyle,
                  ),
                ),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

