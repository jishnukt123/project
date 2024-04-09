import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/admindetails/adminhome.dart';
import 'package:hope/admindetails/adminloading.dart';
import 'package:hope/userdetails/login.dart';
import 'package:hope/userdetails/userloading.dart';
import 'package:hope/userdetails/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admindetails/adminlogin.dart';



class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var data;
  var dat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Center(
          child: Column(
            children: [
              // TextButton(onPressed: (){
              //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>adminloading()));
              // },
              // child: Text("Admin Login"),),
              // TextButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>userloading()));
              // },
              //     child: Text("User Login")),

              SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>adminloading()));
                  }, child: Text("Admin Login"))),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>userloading()));
                },
                    child: Text("User Login")),
              )

              // ElevatedButton(
              //   child: Text('Button'),
              //   onPressed: () {},
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(Colors.red),
              //       padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              //       textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
