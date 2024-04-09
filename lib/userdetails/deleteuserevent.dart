import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/eventviewusr.dart';
import 'package:hope/userdetails/view.dart';
import 'package:http/http.dart' as http;

class deleteuserevent extends StatefulWidget {
  final model data;
  // const eventdetailsusr({Key? key}) : super(key: key);
  deleteuserevent({required this.data});

  @override
  State<deleteuserevent> createState() => _deleteusereventState();
}

class _deleteusereventState extends State<deleteuserevent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Delete Event"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Stack(
                  children:[ Container(
                    height: 600,
                    width: 300,
                    child: Column(
                      children: [
                        Image.asset("assets/images/2ba6fd817cda439c479f435ef02bf3a4.jpg",fit: BoxFit.fill,),
                        Container(
                          child: Column(
                            children: [
                              //Text(widget.data.id,style: TextStyle(color: Colors.black,fontSize: 20)),
                              Text(widget.data.name,style: GoogleFonts.amiri(color: Colors.black,fontSize: 40)),
                              Text(widget.data.description,style: GoogleFonts.amiri(color: Colors.black,fontSize: 40)),
                              Text(widget.data.date,style: GoogleFonts.amiri(color: Colors.black,fontSize: 40)),
                              Text(widget.data.time,style: GoogleFonts.amiri(color: Colors.black,fontSize: 40)),
                              ElevatedButton(onPressed: (){
                                delete(widget.data.id);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>view()));
                              },
                                  child: Text("Cancel event"))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
  delete(String id) async{
    var api="http://192.168.29.92/hope/user/usereventdelete.php";
    http.Response response=await http.post(Uri.parse(api),body: {'Id':id});
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
    {
      Fluttertoast.showToast(msg: res['msg']);
    }
  }
}
