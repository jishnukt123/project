import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../userdetails/view.dart';

class moneyinsert extends StatefulWidget {
  const moneyinsert({Key? key}) : super(key: key);

  @override
  State<moneyinsert> createState() => _moneyinsertState();
}
TextEditingController  name=TextEditingController();
TextEditingController place=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController amount=TextEditingController();
TextEditingController bank=TextEditingController();
TextEditingController account=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _moneyinsertState extends State<moneyinsert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bank Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 600,
            width: 500,
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                //border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(20)
              ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text("Add Bank Details",style: GoogleFonts.allerta(fontSize: 20),),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: name,
                      validator: ((value) {
                        if(value!.isEmpty)
                          {
                            return "Enter name";
                          }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        prefixIcon: Icon(Icons.place),
                        hintText: "Place",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))
                      ),
                      controller: place,
                      validator: ((value) {
                        if(value!.isEmpty)
                          {
                            return "Enter place";
                          }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Phone",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: phone,
                      validator: ((value) {
                        if(value!.isEmpty){
                          return "Enter Phone number";
                        }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        prefixIcon: Icon(Icons.money),
                        hintText: "Amount",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: amount,
                      validator: ((value) {
                        if(value!.isEmpty)
                          {
                            return "Enter your amount";
                          }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance),
                          fillColor: Colors.white,
                          filled: true,
                        hintText: "Bank name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: bank,
                      validator: ((value) {
                        if(value!.isEmpty)
                          {
                            return "Enter your bank";
                          }
                      }),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance),
                          fillColor: Colors.white,
                          filled: true,
                        hintText: "Account",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      controller: account,
                      validator: ((value) {
                        if(value!.isEmpty)
                          {
                            return "Enter account";
                          }
                      }),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      if(formkey.currentState!.validate())
                        {
                          insert();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
                        }
                    },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  insert() async{
    var api="http://192.168.29.92/hope/user/moneyinsert.php";
    Map mapeddata={
      'Name':name.text,
      'Place':place.text,
      'Phone':phone.text,
      'Amount':amount.text,
      'Bank':bank.text,
      'Account': account.text,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
