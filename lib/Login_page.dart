import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/home_chat_bot.dart';
import 'package:login_app/Sign_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _userNameTextController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Create Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SigninPage())); // Quay lại trang trước đó
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userNameTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'User name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              obscureText:
                  _obscureText, // Xác định liệu mật khẩu có bị ẩn hay không
              controller: _passwordTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Đảo ngược trạng thái của mật khẩu ẩn/hiển thị
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(_userNameTextController.text);
                    FirebaseAuth.instance.currentUser!
                        .updateEmail(_emailTextController.text);
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Đặt độ cong 20.0 cho tất cả các góc
                  ),
                ),
                child: const Text(
                  'Sign up ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
