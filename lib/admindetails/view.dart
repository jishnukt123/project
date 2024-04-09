

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/craft.dart';
import 'package:hope/admindetails/viewdetails.dart';

import 'edit.dart';

class view extends StatefulWidget {
  final model data;
  //const view({Key? key, required data}) : super(key: key);
 view({required this.data});
  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            border: Border.all(width: 0),borderRadius: BorderRadius.circular(20)
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(widget.data.name,style: GoogleFonts.amiri(fontSize: 30),),
                Text(widget.data.price,style: GoogleFonts.amiri(fontSize: 30),),
                Text(widget.data.description,style: GoogleFonts.amiri(fontSize: 30),),
                SizedBox(height: 10,),
                Container(
                    height: 200,
                    width: 200,
                    child: Image.network(widget.data.image)),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>edit(id:widget.data.id,name:widget.data.name,price:widget.data.price,description:widget.data.description)));
                },
                    child: Text("Update"))
              ],
            ),
          ),

        ),
      ),
    );
  }
}
