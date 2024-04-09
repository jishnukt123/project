import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/foodupdate.dart';
import 'package:http/http.dart' as http;

import '../userdetails/foodview.dart';

class foodedit extends StatefulWidget {
  final model data;
  //const foodedit({Key? key}) : super(key: key);
  foodedit({required this.data});

  @override
  State<foodedit> createState() => _foodeditState();
}

class _foodeditState extends State<foodedit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(child: Icon(Icons.delete),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context)
              {
                return AlertDialog(
                  backgroundColor: Colors.green.shade100,
                  title: Text("Delete..?"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        child: Text("Cancel")),
                    ElevatedButton(onPressed: (){
                      delete(widget.data.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>foodview()));
                    },
                        child: Text("Delete"))
                  ],
                );
              });
            },),
          )
        ],
        title: Text("Edit"),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: Image.asset("assets/images/foodn.jpg"),
            ),
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration( color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(widget.data.name,style: GoogleFonts.allertaStencil(fontSize: 20),),
                SizedBox(height: 10,),
                Text(widget.data.date,style: GoogleFonts.allertaStencil(fontSize: 20)),
                SizedBox(height: 10,),
                Text(widget.data.food,style: GoogleFonts.allertaStencil(fontSize: 20)),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>foodupdate(id:widget.data.id,name:widget.data.name,date:widget.data.date,food:widget.data.food)));
                },
                    child: Text("Edit"))
              ],
            ),
          ),
        ],
      ),
    );
  }
  delete(String id) async{
    var api="http://192.168.29.92/hope/user/fooddelete.php";
    http.Response response=await http.post(Uri.parse(api),body: {'Id':id});
    var res=jsonEncode(response.body);
  }
}
