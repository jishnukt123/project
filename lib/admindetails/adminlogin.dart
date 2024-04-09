import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/adminhome.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class adminlogin extends StatefulWidget {
  const adminlogin({Key? key}) : super(key: key);

  @override
  State<adminlogin> createState() => _adminloginState();
}
TextEditingController username=TextEditingController();
TextEditingController password=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _adminloginState extends State<adminlogin> {
  var data;
  @override
  void initState() {
    username.clear();
    password.clear();
    // clear();
    // setdata().whenComplete((){
    //   Timer(Duration(seconds: 2),()
    //   {
    //     if(data==null)
    //       {
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>adminlogin()));
    //       }
    //     else
    //       {
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhome()));
    //       }
    //   });
    // });
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
                  border: Border.all(width: 2,color: Colors.blue),borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Icon(Icons.person_outline,size: 100,color: Colors.grey,),
                Text("Welcome Back",style: GoogleFonts.amiri(fontSize: 30)),
                Text("Sign in to continue",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.grey)),
                SizedBox(height: 20,),
                Form(
                  key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail,color: Colors.blue,),
                              labelText: "Username",
                              labelStyle: TextStyle(color: Colors.blue),
                              hintText: "Enter username",
                            ),
                            controller: username,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty..!";
                                }
                            }),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.blue),
                              hintText: "Enter password"
                            ),
                            controller: password,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty..!";
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
                        });
                      }
                  },
                  child: Text("Login",style: GoogleFonts.amiri(fontSize: 20),),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  login() async{
    var api="http://192.168.29.92/hope/admin/adminlogin.php";
    Map mapeddata={
      'Username':username.text,
      'Password':password.text
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>adminlogin()));
      }
    else{
      for(var singleuser in res)
        {
          final pref=await SharedPreferences.getInstance();
          pref.setString('username',singleuser['Username']);
          pref.setString('id',singleuser['Id']);
          pref.setString('email', singleuser['Email']);
          pref.setString('phone', singleuser['Phone']);
        }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhome()));
    }
  }
}
