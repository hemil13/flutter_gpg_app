import 'package:flutter/material.dart';

class StatusApp extends StatefulWidget{
  @override
  StatusMain createState() => StatusMain();
}

class StatusMain extends State<StatusApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Center(
          child: Text("Status Screen",style: TextStyle(fontSize: 30.0,color: Colors.white),),
        ),
      ),
    );
  }

}