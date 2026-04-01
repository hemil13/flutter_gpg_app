import 'package:flutter/material.dart';

class SignupApp extends StatefulWidget{
  @override
  State<SignupApp> createState() => SignupAppState();
}

class SignupAppState extends State<SignupApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
        backgroundColor: Colors.amberAccent.shade700,
      ),
      body: Container(
        child: Center(
          child: Text("Signup Page"),
        ),
      ),
    );
  }
  
}

