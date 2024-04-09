import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/userdetails/foodview.dart';
import 'package:http/http.dart' as http;

class foodupdate extends StatefulWidget {
  late final String id;
  late final String date;
  late final String name;
  late final String food;
  //const foodupdate({Key? key}) : super(key: key);
  foodupdate({required this.id,required this.date,required this.name,required this.food});

  @override
  State<foodupdate> createState() => _foodupdateState();
}
TextEditingController datecontroller=TextEditingController();
TextEditingController name=TextEditingController();
TextEditingController foodtype=TextEditingController();
class _foodupdateState extends State<foodupdate> {
  @override void initState() {
    name=TextEditingController(text: widget.name);
    datecontroller=TextEditingController(text: widget.date);
    foodtype=TextEditingController(text: widget.food);
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Update"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration( color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter new date",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter new name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: foodtype,
                    decoration: InputDecoration(fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter food type",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    edit();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>foodview()));
                  },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  edit() async{
    var api="http://192.168.29.92/hope/user/foodedit.php";
    Map mapeddata={
      'Id':widget.id.toString(),
      'Date':datecontroller.text,
      'Name':name.text,
      'Food_type':foodtype.text,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
