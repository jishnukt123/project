import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/userdetails/event.dart';
import 'package:hope/userdetails/moneyview.dart';
import 'package:http/http.dart' as http;

class moneyupdate extends StatefulWidget {
  late final String id;
  late final String name;
  late final String place;
  late final String phone;
  late final String amount;
  late final String bank;
  late final String account;
  //const moneyupdate({Key? key}) : super(key: key);
  moneyupdate({required this.id,required this.name,required this.place,required this.phone,required this.amount,required this.bank,required this.account});

  @override
  State<moneyupdate> createState() => _moneyupdateState();
}
TextEditingController name=TextEditingController();
TextEditingController place=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController amount=TextEditingController();
TextEditingController bank=TextEditingController();
TextEditingController account=TextEditingController();
class _moneyupdateState extends State<moneyupdate> {
  @override void initState() {
    name=TextEditingController(text: widget.name);
    place=TextEditingController(text: widget.place);
    phone=TextEditingController(text: widget.phone);
    amount=TextEditingController(text: widget.amount);
    bank=TextEditingController(text: widget.bank);
    account=TextEditingController(text: widget.account);
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Edit"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: name,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: place,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: phone,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: amount,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: bank,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: account,
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: (){
                    update();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyview()));
                  },
                      child: Text("Update"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  update() async{
    var api="http://192.168.29.92/hope/user/moneyupdate.php";
    Map mapeddata={
      'Id':widget.id.toString(),
      'Name':name.text,
      'Place':place.text,
      'Phone':phone.text,
      'Amount':amount.text,
      'Bank':bank.text,
      'Account':account.text,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
