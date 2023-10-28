import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/Login_page.dart';
import 'package:login_app/firebase_services.dart';
import 'package:login_app/home_chat_bot.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/reset_password.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _obscureText = true;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(children: [
              SizedBox(height: 25.0),

              Text(
                'ResolveMate',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 50,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 3.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.0),
              //logo icon

              Image.asset(
                'assets/icon/chat_bot.png',
                width: 100,
                height: 100,
              ),

              SizedBox(height: 50.0),
              // username
              TextField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
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

              SizedBox(height: 5.0),
              //sigin button
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reset_password()),
                        (route) => false);
                  },
                  child: Text('Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      )),
                ),
              ]),
              SizedBox(height: 4.0),
              //Creat Account
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (route) => false);
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                      Fluttertoast.showToast(
                          msg: error.toString(), gravity: ToastGravity.TOP);
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
                    'Sign in ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  )),
                  Text('Or continue with'),
                  Expanded(
                      child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  )),
                ],
              ),
              const SizedBox(height: 10.0),
              IconButton(
                  onPressed: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  icon: Image.asset("assets/icon/google.png"))
            ]),
          ),
        ),
      ),
    );
  }
}
