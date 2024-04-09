import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class event extends StatefulWidget {
  const event({Key? key}) : super(key: key);

  @override
  State<event> createState() => _eventState();
}
TextEditingController name=TextEditingController();
TextEditingController description=TextEditingController();
TextEditingController datecontroller=TextEditingController();
TextEditingController timecontroller=TextEditingController();
var Id;
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
class _eventState extends State<event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Event"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              border: Border.all(width: 0),borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Enter details",style: GoogleFonts.acme(fontSize: 30,color: Colors.white),),
                  SizedBox(height: 30,),
                  Form(
                    key: formkey,
                      child:Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
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
                              prefixIcon: Icon(Icons.description),
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
                              prefixIcon: Icon(Icons.date_range),
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
                              prefixIcon: Icon(Icons.access_time_outlined),
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
                              submit();
                              Navigator.pop(context);
                            }

                          },
                              child: Text("Submit"))
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
  submit() async{
    var api="http://192.168.29.92/hope/user/eventinsert.php";
    final pref= await SharedPreferences.getInstance();
    Id=pref.getString('user_id');
    Map mapeddata={
      'User_id':Id.toString(),
      'Name':name.text,
      'Description':description.text,
      'Date':datecontroller.text,
      'Time':timecontroller.text,
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
