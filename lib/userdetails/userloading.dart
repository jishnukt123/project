import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/userdetails/user_login.dart';
import 'package:hope/userdetails/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class userloading extends StatefulWidget {
  const userloading({Key? key}) : super(key: key);

  @override
  State<userloading> createState() => _userloadingState();
}

class _userloadingState extends State<userloading> {
  var data;
  @override
  void initState() {
    setdata().whenComplete((){
      Timer(Duration(seconds: 2),(){
        if(data==null)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>userlogin()));
          }
        else
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
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
    var abc=pref.getString('user_id');
    setState(() {
      data=abc;
    });
  }
}
