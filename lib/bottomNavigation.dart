import 'package:flutter/material.dart';
import 'package:flutter_gpg_app/call.dart';
import 'package:flutter_gpg_app/chat.dart';
import 'package:flutter_gpg_app/status.dart';


class BottomDemo extends StatefulWidget{

  @override
  BottomState createState() => BottomState();

}

class BottomState extends State<BottomDemo>{

  var tabArray = [ChatApp(),StatusApp(),CallApp()];
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bottom Navigation"),
          backgroundColor: Colors.amber.shade100,
        ),
        body: tabArray[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
            )
          ],
          currentIndex: selectedIndex,
          onTap: (index){
            setBottomIndex(index);
          },
        ),
      ),
    );
  }

  setBottomIndex(index){
    setState(() {
      print(index);
      selectedIndex = index;
    });
  }

}