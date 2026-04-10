import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavigationMain extends StatefulWidget{

  @override
  NavigationApp createState() => NavigationApp();

}

class NavigationApp extends State<NavigationMain>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Navigation Drawer"),
          backgroundColor: Colors.amber.shade100,
        ),
        drawer: Drawer(
          child: new ListView(
            children: [
              UserAccountsDrawerHeader(                
                accountName: Text("Navigator"), 
                accountEmail: Text("navigator@gmail.com"),
                currentAccountPicture: Icon(Icons.verified_user),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                subtitle: Text("Go to Home Screen"),
                trailing: Icon(Icons.arrow_forward_ios),
                hoverColor: Colors.amberAccent,
                onTap: (){
                  printMessage("Home");
                  //print("Home");
                },
                onLongPress: (){
                  printMessage("Long Press on Home");
                },
              ),

              ListTile(
                title: Text("Orders"),
                leading: Icon(Icons.shopping_cart),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  printMessage("Orders");
                  //print("Orders");
                },
              ),

              ListTile(
                title: Text("Wishlist"),
                leading: Icon(Icons.favorite),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  printMessage("Wishlist");
                  //print("Wishlist");
                },
              ),

              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  printMessage("Profile");
                  //print("Profile");
                },
              ),

              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  printMessage("Logout");
                  //print("Logout");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  printMessage(var message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG
    );
  }

}