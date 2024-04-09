import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/userdetails/view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class payment_tb extends StatefulWidget {
   final String total;
  payment_tb({ required this.total});

  @override
  State<payment_tb> createState() => _payment_tbState();
}
TextEditingController name=TextEditingController();
TextEditingController bank=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController account=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
var user_id;
class _payment_tbState extends State<payment_tb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 500,
            width: 300,

            decoration: BoxDecoration(
                color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: name,
                      validator: ((value) {
                        if(value!.isEmpty){
                          return "Empty...";
                        }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        hintText: "Enter your bank",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: bank,
                      validator: ((value) {
                        if(value!.isEmpty){
                          return "Empty...";
                        }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        hintText: "Enter your phone",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: phone,
                      keyboardType: TextInputType.number,
                      validator: ((value) {
                        if(value!.isEmpty){
                          return "Empty...";
                        }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        hintText: "Enter your account",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: account,
                      validator: ((value) {
                        if(value!.isEmpty){
                          return "Empty...";
                        }
                      }),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Total amount   :",style: TextStyle(color: Colors.black,fontSize: 20),),
                        Text(widget.total,style: TextStyle(fontSize: 20,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      if(formkey.currentState!.validate())
                        {
                          setState(() {
                            payment();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
                          });
                        }
                    },
                        child: Text("Place order"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  payment() async{
    var api="http://192.168.29.92/hope/user/ordertbinsert.php";
    final pref=await SharedPreferences.getInstance();
    user_id=pref.getString('user_id');
    Map mapeddata={
      'User_id':user_id.toString(),
      'Name':name.text,
      'Bank':bank.text,
      'Phone':phone.text,
      'Account':account.text,
      'Total':widget.total,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
  }
}
