import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/craft.dart';
//import 'package:hope/userdetails/twotbcraftview.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'viewcraft.dart';



class details extends StatefulWidget {
  final model data;
  //const details({Key? key, required data}) : super(key: key);
  details({required this.data});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20)
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
               // Text(widget.data.id),
                SizedBox(height: 5,),
                Text(widget.data.name,style: GoogleFonts.aladin(fontSize: 20),),
                SizedBox(height: 10,),
                Text(widget.data.price,style: GoogleFonts.aladin(fontSize: 20)),
                SizedBox(height: 10,),
                Text(widget.data.description,style: GoogleFonts.aladin(fontSize: 20)),
                SizedBox(height: 10,),
                Container(
                  height: 200,
                  width: 300,
                  child: Image.network(widget.data.image),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  cart();
                },
                    child: Text("Add to craft"),),
              ],
            ),
          ),

        ),
      ),
    );
  }
  cart() async{
    var api="http://192.168.29.92/hope/user/cart.php";
    final pref=await SharedPreferences.getInstance();
    var abc=pref.getString('user_id');
    Map mapeddata={
      'Craft_id':widget.data.id,
      'User_id':abc.toString(),
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
