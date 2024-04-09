import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import 'home.dart';

class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);

  @override
  State<form> createState() => _formState();
}
TextEditingController username=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController password=TextEditingController();
TextEditingController conpassword=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _formState extends State<form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("REGISTRATION"),
        leading: Icon(Icons.format_align_center),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.green.shade200,
                border: Border.all(width: 0,), borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("User Registration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons. drive_file_rename_outline),
                              fillColor: Colors.white,
                              filled: true,
                               //labelText: "Name",
                              hintText: "Enter Username",
                              hintStyle: GoogleFonts.aladin(),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: username,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty...";
                                }
                            }),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter email",
                              hintStyle: GoogleFonts.aladin(),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            controller: email,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty...";
                                }
                            }),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                fillColor: Colors.white,
                                filled: true,
                              hintText: "Enter phone no:",
                                hintStyle: GoogleFonts.aladin(),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: phone,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty...";
                                }
                            }),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              hintText: "Enter password",
                              hintStyle: GoogleFonts.aladin(),
                            ),
                            controller: password,
                            validator: ((value) {
                              if(value!.isEmpty){
                                return "Empty...";
                              }
                            }),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                fillColor: Colors.white,
                                filled: true,
                              hintText: "Enter re-password",
                                hintStyle: GoogleFonts.aladin(),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: conpassword,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty...!";
                                }
                              if(value!=password.text)
                                {
                                  return "Invalid password";
                                }
                            }),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            if(formkey.currentState!.validate())
                              {
                                setState(() {
                                  insert();
                                });
                              }
                          },
                              child: Text("Register")),
                          SizedBox(height: 10,),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                          },
                              child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.black),))
                        ],
                      )),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
Future insert()async
{
  var api="http://192.168.29.92/hope/user/userinsert.php";
  Map mapeddata={
    'Username':username.text,
    'Email':email.text,
    'Phone':phone.text,
    'Password':password.text
  };
  http.Response response=await http.post(Uri.parse(api),body: mapeddata);
  var res=jsonDecode(response.body);
  if(res['status_code']==200)
    {
      Fluttertoast.showToast(msg: res['msg']);
    }
}
}
