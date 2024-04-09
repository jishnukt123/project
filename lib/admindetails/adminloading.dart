import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/admindetails/adminhome.dart';
import 'package:hope/admindetails/adminlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminloading extends StatefulWidget {
  const adminloading({Key? key}) : super(key: key);

  @override
  State<adminloading> createState() => _adminloadingState();
}

class _adminloadingState extends State<adminloading> {
  var data;
  @override
  void initState() {
    setdata().whenComplete((){
      Timer(Duration(seconds: 1),(){
        if(data==null)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>adminlogin()));
          }
        else
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhome()));
          }
      });
    });
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 300,),
              CircularProgressIndicator(color: Colors.blue,),
              Text("Loading")
            ],
          ),
        ),
      ),
    );
  }
  setdata() async{
    final pref=await SharedPreferences.getInstance();
    var abc=pref.getString('id');
    setState(() {
      data=abc;
    });
  }
}
