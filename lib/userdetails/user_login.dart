import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/form.dart';
import 'package:hope/userdetails/view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class user_login extends StatefulWidget {
  const user_login({Key? key}) : super(key: key);

  @override
  State<user_login> createState() => _user_loginState();
}
TextEditingController username=TextEditingController();
TextEditingController password=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _user_loginState extends State<user_login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("User Login"),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>form()));
          },
              child: Text("SignUp",style: TextStyle(color: Colors.white),))
                  ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green,width: 2),
              borderRadius: BorderRadius.circular(20),
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
                            prefixIcon: Icon(Icons.mail,color: Colors.green,),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.green),
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
                              prefixIcon: Icon(Icons.lock,color: Colors.green,),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.green),
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
                    child: Text("Login",style: GoogleFonts.amiri(fontSize: 20),),)
                ),

              ],
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
    if(res!=null)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>user_login()));

    }
    else
    {
      for(var singleuser in res)
      {
        final pref=await SharedPreferences.getInstance();
        pref.setString('username',username.text);
        pref.setString('id',singleuser['Id']);
        pref.setString('name',singleuser['Name']);
        pref.setString('email', singleuser['Email']);
        pref.setString('phone', singleuser['Phone']);
        pref.setString('address', singleuser['Address']);
        pref.setString('place', singleuser['Place']);
        pref.setString('gender', singleuser['Gender']);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
    }
  }
}
