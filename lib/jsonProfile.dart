import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpg_app/constantData.dart';
import 'package:flutter_gpg_app/jsonLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JsonProfileApp extends StatefulWidget{

  @override
  JsonProfileState createState() => JsonProfileState();

}

class JsonProfileState extends State<JsonProfileApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sUserId,sName,sEmail,sContact,sPassword,sConfirmPassword;
  late SharedPreferences sp;
  var nameController,emailController,contactController,passwordController,confirmPasswordController;
 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  setData() async{
    sp = await SharedPreferences.getInstance();
    setState(() {
      sUserId = sp.getString(Constantdata.USERID) ?? "";
      sName = sp.getString(Constantdata.NAME) ?? "";
      sEmail = sp.getString(Constantdata.EMAIL) ?? "";
      sContact = sp.getString(Constantdata.CONTACT) ?? "";
      sPassword = sp.getString(Constantdata.PASSWORD) ?? "";

      nameController = TextEditingController(text: sName);
      emailController = TextEditingController(text: sEmail);
      contactController = TextEditingController(text: sContact);
      passwordController = TextEditingController(text: sPassword);

      print(sName);
      print(sPassword);
    


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.amber.shade100,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Name",
                      hintText: "Enter Name",
                    ),
                    onSaved: (value){
                      sName = value!;
                    },
                    validator: (value){
                      if (value!.isEmpty){
                        return "Name Required";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Email",
                      hintText: "Enter Email Id",
                    ),
                    onSaved: (value){
                      sEmail = value!;
                    },
                    validator: (value){
                      if (value!.isEmpty){
                        return "Email Id Required";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Contact No.",
                      hintText: "Enter Contact No.",
                    ),
                    onSaved: (value){
                      sContact = value!;
                    },
                    validator: (value){
                      if (value!.isEmpty){
                        return "Contact No. Required";
                      }
                      else if(value.length<10){
                        return "Valid Contact No. Required";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Password",
                      hintText: "Enter Password",
                    ),
                    onSaved: (value){
                      sPassword = value!;
                    },
                    validator: (value){
                      if (value!.isEmpty){
                        return "Password Required";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Enter Confirm Password",
                    ),
                    onSaved: (value){
                      sConfirmPassword = value!;
                    },
                    validator: (value){
                      if (value!.isEmpty){
                        return "Confirm Password Required";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    color: Colors.blue.shade300,
                    width: 200.0,
                    height: 40.0,
                    child: TextButton(
                      onPressed: () async {
                        var connection = await Connectivity().checkConnectivity();
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          if(sPassword != sConfirmPassword){
                            Fluttertoast.showToast(
                              msg: "Password Does Not Match",
                              toastLength: Toast.LENGTH_SHORT
                              );
                          }
                        }
                        
                      }, 
                      child: Text("Update Profile")
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    color: Colors.blue.shade300,
                    width: 200.0,
                    height: 40.0,
                    child: TextButton(
                      onPressed: () async {
                        doLogout();
                      }, 
                      child: Text("Logout")
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    color: Colors.blue.shade300,
                    width: 200.0,
                    height: 40.0,
                    child: TextButton(
                      onPressed: () async {
                        doDelete(sUserId);
                      }, 
                      child: Text("Delete Profile")
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void doDelete(sUserId) async {
    var map = {
      "userid" : sUserId
    };

    var data = await http.post(Uri.parse(Constantdata.BASE_URL+"deleteProfile.php"),body: map);
    if(data.statusCode == 200){
      var jsonData = json.decode(data.body);
      if(jsonData["Status"] == true){
        Fluttertoast.showToast(
          msg: jsonData["Message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );

        doLogout();
      }
      else{
        Fluttertoast.showToast(
          msg: jsonData["Message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );
      }
    }
    else{
      Fluttertoast.showToast(
        msg: "Server Error Code : ${data.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0
      );
    }

  }

  void doLogout(){
    sp.clear();
    Navigator.push(context, MaterialPageRoute(builder: (_)=> JsonLoginApp()));
  }

  void insertData(sUserId,sName,sEmail,sContact,sPassword,) async{
    var map = {
        'userid' : sUserId,
        'name' : sName,
        'email' : sEmail,
        'contact' : sContact,
        'password' : sPassword,
    
      };

    var data = await http.post(Uri.parse(Constantdata.BASE_URL+'updateProfile.php'),body: map);
    if(data.statusCode == 200){
      var jsonData = json.decode(data.body);
      if(jsonData["Status"] == true){
        Fluttertoast.showToast(
          msg: jsonData["Message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );

        sp.setString(Constantdata.USERID, sUserId);
        sp.setString(Constantdata.NAME, sName);
        sp.setString(Constantdata.EMAIL, sEmail);
        sp.setString(Constantdata.CONTACT, sContact);
        sp.setString(Constantdata.PASSWORD, sPassword);
      }
      else{
        Fluttertoast.showToast(
          msg: jsonData["Message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );
      }
    }
    else{
      Fluttertoast.showToast(
        msg: "Server Error Code : ${data.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0
      );
    }

  }

}