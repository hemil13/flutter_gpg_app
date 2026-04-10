import 'package:flutter/material.dart';

class CallApp extends StatefulWidget{
  @override
  CallMain createState() => CallMain();
}

class CallMain extends State<CallApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text("Call Screen",style: TextStyle(fontSize: 30.0,color: Colors.white),),
        ),
      ),
    );
  }

}