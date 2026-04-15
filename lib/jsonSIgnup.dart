import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpg_app/SqliteHelper.dart';
import 'package:flutter_gpg_app/constantData.dart';
import 'package:flutter_gpg_app/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class JsonSignupApp extends StatefulWidget{

  @override
  JsonSignupState createState() => JsonSignupState();

}

class JsonSignupState extends State<JsonSignupApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sName,sEmail,sContact,sPassword,sConfirmPassword;
 

  late String sCity = "Ahmedabad";
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: TextFormField(
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
                        else{
                          if (connection.contains(ConnectivityResult.mobile) || connection.contains(ConnectivityResult.wifi)){
                            insertData(sName,sEmail,sContact,sPassword);
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: "Internet/Wifi Not Connected",
                              toastLength: Toast.LENGTH_SHORT
                            );
                          }
                          //insertData(sName,sEmail,sContact,sPassword);
                        }
                      }
                      
                    }, 
                    child: Text("Signup")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void insertData(sName,sEmail,sContact,sPassword) async{
    var map = {
        'name' : sName,
        'email' : sEmail,
        'contact' : sContact,
        'password' : sPassword
      };

    var data = await http.post(Uri.parse(Constantdata.BASE_URL+'signup.php'),body: map);
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
        Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginApp()));
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