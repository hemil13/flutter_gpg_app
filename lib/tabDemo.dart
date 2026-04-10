import 'package:flutter/material.dart';
import 'package:flutter_gpg_app/call.dart';
import 'package:flutter_gpg_app/chat.dart';
import 'package:flutter_gpg_app/status.dart';


class TabApp extends StatefulWidget{

  @override
  TabMain createState() => TabMain();

}

class TabMain extends State<TabApp> with SingleTickerProviderStateMixin{

  late TabController tabController;
  var tabArray = [ChatApp(), CallApp(), StatusApp()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabArray.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tab Demo"),
          bottom: getTab(),
        ),
        body: getTabView()
      ),
    );
  }

  getTab(){
    return TabBar(
      tabs : [
        Tab(text: "Chat",),
        Tab(text: "Call",),
        Tab(text: "Status",)
      ],
      controller: tabController,
      unselectedLabelColor: Colors.black,
      labelColor: Colors.red,
      indicatorColor: Colors.deepPurple,
    );
  }

  getTabView(){
    return TabBarView(
      children: tabArray,
      controller: tabController,
    );
  }

}