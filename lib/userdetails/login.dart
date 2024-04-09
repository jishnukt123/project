import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/form.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hope/userdetails/view.dart';


class userlogin extends StatefulWidget {
  const userlogin({Key? key}) : super(key: key);

  @override
  State<userlogin> createState() => _userloginState();
}
TextEditingController username=TextEditingController();
TextEditingController password=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _userloginState extends State<userlogin> {
  @override
  void initState() {
    username.clear();
    password.clear();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("User Login"),
        backgroundColor: Colors.green,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>form()));
          },
              child: Text("SignUp",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(width: 2,color: Colors.green),borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Icon(Icons.person_outline,size: 100,color: Colors.grey),
                  SizedBox(height: 13,),
                  Text("Welcome Back",style: GoogleFonts.amiri(fontSize: 30,fontWeight: FontWeight.bold)),
                  Text("Sign in to continue",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.grey),),
                  SizedBox(height: 10,),
                  Form(
                    key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                  labelText: "Username",
                                  labelStyle: TextStyle(color: Colors.green),
                                  hintText: "Enter username",
                                  hintStyle: GoogleFonts.share()
                              ),
                              controller: username,
                              validator: ((value) {
                                if(value!.isEmpty){
                                  return "username should not empty";
                                }
                              }),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.green),
                                  hintText: "Enter password",
                                  hintStyle: GoogleFonts.share()
                              ),
                              controller: password,
                              validator: ((value) {
                                if(value!.isEmpty){
                                  return "password should not empty";
                                }
                              }),
                            ),
                          ),
                        ],
                      ),

                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 190),
                    child: FloatingActionButton(onPressed: (){
                        if(formkey.currentState!.validate())
                          {
                            setState(() {
                              login();
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
                            });
                          }
                    },
                      child: Text("Login",style: GoogleFonts.amiri(fontSize: 20)),backgroundColor: Colors.green,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future login() async
  {
    var api="http://192.168.29.92/hope/user/userlogin.php";
    Map mapeddata={
      'Username':username.text,
      'Password':password.text
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res==null)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>userlogin()));

    }
    else
    {
      for(var singleuser in res)
      {
        final pref=await SharedPreferences.getInstance();
        pref.setString('user', singleuser['Username']);
        pref.setString('uname',singleuser['Username']);
        pref.setString('uemail', singleuser['Email']);
        pref.setString('uphone',singleuser['Phone']);
        pref.setString('user_id', singleuser['Id']);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
    }
  }
  // login() async{
  //   var api="http://192.168.29.92/hope/user/userlogin.php";
  //   Map mapeddata={
  //     'Username':username.text,
  //     'Password':password.text
  //   };
  //   http.Response response=await http.post(Uri.parse(api),body: mapeddata);
  //   var res=jsonDecode(response.body);
  //   if(res==null)
  //     {
  //        //Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
  //     }
  //   else
  //     {
  //       for(var singleuser in res)
  //         {
  //           final pref=await SharedPreferences.getInstance();
  //           pref.setString('user', singleuser['Username']);
  //           pref.setString('uname',singleuser['Username']);
  //           pref.setString('uemail', singleuser['Email']);
  //           pref.setString('uphone',singleuser['Phone']);
  //           pref.setString('user_id', singleuser['Id']);
  //         }
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
  //
  //     }
  // }
}
