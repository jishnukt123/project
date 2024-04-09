import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/home.dart';
import 'package:hope/userdetails/event.dart';
import 'package:hope/userdetails/eventviewuser2.dart';
import 'package:hope/userdetails/foodinsert.dart';
import 'package:hope/userdetails/foodview.dart';
import 'package:hope/userdetails/moneyinsert.dart';
import 'package:hope/userdetails/moneyview.dart';
import 'package:hope/userdetails/orderview.dart';
import 'package:hope/userdetails/twotbcraftview.dart';
import 'package:hope/userdetails/userview.dart';
import 'package:hope/userdetails/view_events.dart';
import 'package:hope/userdetails/viewcraft.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../form.dart';
import 'eventviewusr.dart';


class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}
var data;
var r;
class _viewState extends State<view> {
  @override
  void initState() {
    setState(() {
      user();
    });
    // TODO: implement initState
    super.initState();
  }
  user() async{
    final pref=await SharedPreferences.getInstance();
    data=pref.getString('user');
     r=pref.getString('uname');
  }
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.green,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(child: Icon(Icons.logout),
          onTap: (){
            showDialog(context: context,
                builder: (BuildContext context){
              return AlertDialog(
                backgroundColor: Colors.green.shade100,
                title: Text("Log Out..?"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
                  ElevatedButton(onPressed: (){
                    logout();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                  }, child: Text("Ok"))
                ],
              );
                });

          },),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0,),
            Card(
              elevation: 5,
              shadowColor: Colors.green,
              color: Colors.green.shade300,
              child: ListTile(
                leading: Icon(Icons.person,size: 30,color: Colors.white,),
                title: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(r,style: GoogleFonts.acme(fontSize: 30,color: Colors.white),),
                ),
              ),
            ),
            Container(
              height: 250,
              width: 300,
              child: Image.asset("assets/images/tree-736885_1280.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                height: 300,
                width: 500,
                child: Stack(
                  children: [
                    InkWell(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          //border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Image.asset("assets/images/istockphoto-1316420668-612x612.jpg",fit: BoxFit.fill,)
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>userview()));
                      },
                    ),
                    Positioned(left: 150,
                        child: InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              //border: Border.all(width: 0),
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child:Image.asset("assets/images/craft.jpg")
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>viewcraft()));
                          },
                        )),
                    Positioned(
                        top: 120,
                        child: InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              //border: Border.all(),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            //color: Colors.green,
                            child: Image.asset("assets/images/cart1.jpg")
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>twotbcraftview()));
                          },
                        )
                    ),
                    Positioned(
                        left: 150,
                        top: 120,
                        child: InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              //border: Border.all(),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            //color: Colors.blue,
                            child:Image.asset("assets/images/bank.jpg")
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyview()));
                          },
                        ))
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration( color: Colors.green,
                  borderRadius: BorderRadius.circular(20)
                ),

                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.person_pin,color: Colors.white,size: 40,),
                    SizedBox(width: 50,),
                    Text(data,style: TextStyle(fontSize: 30,color: Colors.white),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>userview()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 190),
                      child: Text("Profile",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>viewcraft()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 160),
                      child: Text("Cart Details",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>event()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text("add event",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>view_events()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text("event view",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>eventviewuser2()));

                }, child: Padding(
                  padding: const EdgeInsets.only(right: 170),
                  child: Text("Edit event",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>eventviewusr()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 160),
                      child: Text("Delete event",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>foodinsert()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text("Food",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>foodview()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 160),
                      child: Text("food details",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyinsert()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text("Bank",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyview()));
                }, child: Padding(
                  padding: const EdgeInsets.only(right: 160),
                  child: Text("Bank details",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>twotbcraftview()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text("View craft",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>orderview()));
                },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text("View order",style: GoogleFonts.share(fontSize: 20,color: Colors.green)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  logout()async{
    final pref=await SharedPreferences.getInstance();
    pref.clear();
  }
}
