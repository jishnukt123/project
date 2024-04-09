import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class foodinsert extends StatefulWidget {
  const foodinsert({Key? key}) : super(key: key);

  @override
  State<foodinsert> createState() => _foodinsertState();
}
TextEditingController datecontroller=TextEditingController();
TextEditingController name=TextEditingController();
TextEditingController foodtype=TextEditingController();
final GlobalKey<FormState> formkey=GlobalKey<FormState>();
var user;
class _foodinsertState extends State<foodinsert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Food details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Add Food Details",style: GoogleFonts.alegreyaSc(fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range,),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Choose date",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: datecontroller,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty";
                                }
                            }),
                            onTap: () async{
                              DateTime? date=await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1998),
                                  lastDate: DateTime(2050));
                              setState(() {
                                datecontroller.text=DateFormat('dd/MM/yyy').format(date!);
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.text_fields),
                                fillColor: Colors.white,
                                filled: true,
                              hintText: "Enter name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: name,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty";
                                }
                            }),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fastfood_outlined),
                                fillColor: Colors.white,
                                filled: true,
                              hintText: "Enter food name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ),
                            controller: foodtype,
                            validator: ((value) {
                              if(value!.isEmpty)
                                {
                                  return "Empty";
                                }
                            }),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            if(formkey.currentState!.validate())
                              {
                                insert();
                              }

                          },
                              child: Text("Save"))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  insert() async{
    var api="http://192.168.29.92/hope/user/foodtb.php";
    final pref=await SharedPreferences.getInstance();
    user=pref.getString('user_id');
    Map mapeddata={
      'Date':datecontroller.text,
      'Name':name.text,
      'Food_type':foodtype.text,
      'User_id':user.toString()
    };
    http.Response response=await http.post(Uri.parse(api),body: mapeddata);
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
      {
        Fluttertoast.showToast(msg: res['msg']);
      }
  }
}
