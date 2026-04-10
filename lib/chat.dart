import 'package:flutter/material.dart';

class ChatApp extends StatefulWidget{
  @override
  ChatMain createState() => ChatMain();
}

class ChatMain extends State<ChatApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigoAccent,
        child: Center(
          child: Text("Chat Screen",style: TextStyle(fontSize: 30.0,color: Colors.white),),
        ),
      ),
    );
  }

}