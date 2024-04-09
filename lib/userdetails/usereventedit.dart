import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/eventviewuser2.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class usereventedit extends StatefulWidget {
  final model data;
  // const eventdetailsusr({Key? key}) : super(key: key);
  usereventedit({required this.data});

  @override
  State<usereventedit> createState() => _usereventeditState();
}
TextEditingController name=TextEditingController();
TextEditingController description=TextEditingController();
TextEditingController datecontroller=TextEditingController();
TextEditingController timecontroller=TextEditingController();
var Id;
final GlobalKey<FormState> formkey=GlobalKey<FormState>();

class _usereventeditState extends State<usereventedit> {
  @override
  void initState() {
    Id=TextEditingController(text: widget.data.id);
    name=TextEditingController(text: widget.data.name);
    description=TextEditingController(text: widget.data.description);
    datecontroller=TextEditingController(text: widget.data.date);
    timecontroller=TextEditingController(text: widget.data.time);
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

            decoration: BoxDecoration(
                color: Colors.green.shade300,
                border: Border.all(width: 2),borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Enter details",style: GoogleFonts.aladin(fontSize: 30,color: Colors.white),),
                  SizedBox(height: 30,),
                  Form(
                      key: formkey,
                      child:Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                hintText: "Enter name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            controller: name,
                            validator: ((value) {
                              if(value!.isEmpty){
                                return "Enter name...";
                              }
                            }),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                hintText: "Enter description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            controller: description,
                            validator: ((value) {
                              if(value!.isEmpty){
                                return "Enter description...";
                              }
                            }),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Choose date",
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            controller: datecontroller,
                            validator: ((value) {
                              if(value!.isEmpty){
                                return "chosse date..";
                              }
                            }),
                            onTap: () async{
                              DateTime? date=await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1998),
                                lastDate: DateTime(2050),
                              );
                              setState(() {
                                datecontroller.text=DateFormat('dd/MM/yyyy').format(date!);
                              });
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Choose time",
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                            ),
                            controller: timecontroller,
                            validator: ((value) {
                              if(value!.isEmpty){
                                return "choose time..";
                              }
                            }),
                            onTap: () async {
                              var Time=await showTimePicker(context: context,
                                  initialTime: TimeOfDay.now());
                              if(Time!=null)
                              {
                                setState(() {
                                  timecontroller.text=Time.format(context);
                                });
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            if(formkey.currentState!.validate()){
                               update();
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>eventviewuser2()));
                            }

                          },
                              child: Text("Update"))
                        ],
                      )
                  )
                ],
              ),
            ),

          ),
        ),
      )
    );
  }
  update() async{
    var api="http://192.168.29.92/hope/user/usereventupdate.php";
    Map mapeddata={
      'Id':widget.data.id.toString(),
      'Name':name.text,
      'Description':description.text,
      'Date':datecontroller.text,
      "Time":timecontroller.text,
    };
    // print(mapeddata);
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
    {
      Fluttertoast.showToast(msg: res['msg']);
    }
  }
}
