import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/Sign_page.dart';

class reset_password extends StatefulWidget {
  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
      backgroundColor: Colors.blue[900],
      title: Text('Reset Password'),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage())); // Quay lại trang trước đó
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          SizedBox(height: 16.0),
            
             TextField(  
                  controller: _emailTextController,
                  decoration:  InputDecoration(
                    prefixIcon:Icon( Icons.lock_outline,color: Colors.black),
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width : 1 , color:Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide : BorderSide(color:Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                  ),
                
            ),
             
            SizedBox(height: 24.0),
            
            Container(
                    width: double.infinity,
                    height: 50,
                   child: ElevatedButton(
                      onPressed: (){
                       FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text).then((value) => 
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage())));

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Đặt độ cong 20.0 cho tất cả các góc
                        ),
                      ),
                      child: const Text(
                        'Reset Password',
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
