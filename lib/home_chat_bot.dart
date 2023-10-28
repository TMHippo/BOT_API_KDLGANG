import 'package:login_app/Messages.dart';

import 'package:flutter/material.dart';
import 'package:login_app/Sign_page.dart';
import 'package:login_app/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _controller = TextEditingController();
  Future<void> sendMessageToBot(String text) async {
    final String url =
        'https://sever-python-fastapi-dialogflowcx1.onrender.com/detect_intent_text?text=' +
            text;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        
        addMessage(data['response'].toString(), false);
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  List<Map<String, dynamic>> messages = [];
  String userEmail = "";
  String userName = "";

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userEmail = user.email ?? "";
      userName = user.displayName ?? "";
    } else {
      userEmail = 'NULL';
      userName = 'NULL';
    }
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        // leading: Builder(builder: (context) {
        //   return IconButton(
        //     icon: Image.asset(
        //       'assets/icon/complaint.png',
        //       width: 25,
        //     ),
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //           context, MaterialPageRoute(builder: (context) => Home()));
        //     },
        //   );
        // }),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Image.asset('assets/icon/chat_bot.png', width: 40),
            ),
            const SizedBox(width: 3), // khoang cach cua icon và chat bot
            Text(
              "ResolveMate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade400,
        titleTextStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      endDrawer: Navigation_Drawer(userName.toString(), userEmail),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.blue.shade300,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      icon: Image.asset(
                        'assets/icon/clear.png',
                        width: 20,
                      )),
                  const SizedBox(width: 30),
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "send a message",
                    ),
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                  )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

 sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(text,true);
      });
      sendMessageToBot(text);
    }
  }

  addMessage(String message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}

class Navigation_Drawer extends StatelessWidget {
  final String name;
  final String email;

  Navigation_Drawer(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildheader(context, name, email),
            buildmenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildheader(BuildContext context, String name, String email) => Material(
      color: Colors.blue[300],
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
              top: 20 + MediaQuery.of(context).padding.top, bottom: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: Colors.blue[900],
                child: FirebaseAuth.instance.currentUser?.photoURL != null
                    ? ClipOval(
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                          width: 104,
                          height: 104,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildmenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.account_box),
            title: const Text('Account'),
            onTap: () {},
          ),
          const Divider(
            color: Colors.black45,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              await FirebaseServices().signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SigninPage()));
            },
          ),
        ],
      ),
    );
