import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/admindetails/view.dart';
import 'package:hope/admindetails/viewdetails.dart';
import 'package:hope/userdetails/view.dart';
import 'package:http/http.dart' as http;



class edit extends StatefulWidget {
  // final  model data;
  late final String id;
 late final String name;
 late final String price;
 late final String description;

edit({required this.name,required this.price,required this.description, required this.id});

  @override
  State<edit> createState() => _editState();
}
TextEditingController craft_id=TextEditingController();
TextEditingController name=TextEditingController();
TextEditingController price=TextEditingController();
TextEditingController description=TextEditingController();
class _editState extends State<edit> {
  @override
  void initState() {
    name=TextEditingController(text: widget.name);
     price=TextEditingController(text: widget.price);
     description=TextEditingController(text: widget.description);
    //TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Update"),
        actions: [
          InkWell(child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.delete),
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Delete?"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text("Cancel")),
                      ElevatedButton(onPressed: (){
                        delete(widget.id);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>viewdetails()));
                      }, child: Text("Delete"))
                    ],

                  );
                }
            );
          },)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 400,
          width: 500,
          decoration: BoxDecoration(color: Colors.blue.shade300,
            border: Border.all(),
              borderRadius: BorderRadius.circular(20)
          ),

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  controller: name,
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter price",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  controller: price,
                ),SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter descrkiption",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  controller: description,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 100,),
                    ElevatedButton(onPressed: (){
                      update();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>viewdetails()));
                    },

                        child: Text("Update")),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  update() async{
    var api="http://192.168.29.92/hope/admin/adminupdate.php";
    Map mapeddata={
      'Id':widget.id.toString(),
      'Name':name.text,
      'Price':price.text,
      'Description':description.text,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
  delete(String id) async{
    var api="http://192.168.29.92/hope/admin/admindelete.php";
    http.Response response=await http.post(Uri.parse(api),body: {'id':id});
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
    {
    Fluttertoast.showToast(msg: res['msg']);
    }

  }
}
