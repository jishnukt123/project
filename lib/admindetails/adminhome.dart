import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/adminorderview.dart';
import 'package:hope/admindetails/adminprofile.dart';
import 'package:hope/admindetails/craft.dart';
import 'package:hope/admindetails/fooddetails.dart';
import 'package:hope/admindetails/moneydetails.dart';
import 'package:hope/admindetails/viewdetails.dart';
import 'package:hope/admindetails/viewevent.dart';
import 'package:hope/form.dart';
import 'package:hope/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminhome extends StatefulWidget {
  const adminhome({Key? key}) : super(key: key);

  @override
  State<adminhome> createState() => _adminhomeState();
}
var Name;
class _adminhomeState extends State<adminhome> {
  @override void initState() {
    admin();
    // TODO: implement initState
    super.initState();
  }
  admin() async{
    final pref=await SharedPreferences.getInstance();
    Name=pref.getString('username');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(child: Icon(Icons.logout),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context)
              {
                return AlertDialog(
                  backgroundColor: Colors.blue.shade100,
                  title: Text("Log Out..?"),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        child: Text("Cancel")),
                    ElevatedButton(onPressed: (){
                      exit();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                    },
                        child: Text("Ok"))
                  ],
                );
              });

            },),
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            //color: Colors.red,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
              tileColor: Colors.blue.shade300,
              title: Center(child: Text(Name,style: TextStyle(fontSize: 30,color: Colors.black),)),
            ),
          ),
          Container(
            //color: Colors.grey,
            height: 250,
            width: 300,
            child: Image.asset("assets/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
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
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      //color: Colors.yellow,
                      child:Image.asset("assets/images/Events.jpg"),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>viewevent()));
                    },
                  ),
                  Positioned(
                    left: 150,
                    child: InkWell(
                      child: Container(
                        height: 100,
                        width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                       // color: Colors.red,
                        child: Image.asset("assets/images/order.webp")
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>adminorderview()));
                      },
                    ),
                  ),
                  Positioned(
                      top: 120,
                      child: InkWell(
                        child: Container(
                          height: 100,
                          width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          //color: Colors.grey,
                          child: Image.asset("assets/images/foodn.jpg")
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>fooddetails()));
                        },
                      )),
                  Positioned(
                    left: 150,
                      top: 120,
                      child: InkWell(
                        child: Container(
                          height: 100,
                          width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20)
                            ),
                         // color: Colors.pink,
                          child: Image.asset("assets/images/bank.jpg")
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>moneydetails()));
                        },
                      ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue.shade50,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration( color: Colors.blue,
                  //border: Border.all(),
                  borderRadius: BorderRadius.circular(20)
                ),

                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.person_sharp,color: Colors.white,size: 40,),
                        SizedBox(width: 70,),
                        Text(Name,style: GoogleFonts.balooBhaina2(fontSize: 30,color: Colors.white),),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>adminprofile()));
              }, child: Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text("Profile",style: GoogleFonts.share(fontSize: 20),),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>craft()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 190),
                    child: Text("Add Craft",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>viewdetails()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 170),
                    child: Text("View Details",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>viewevent()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 180),
                    child: Text("View event",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>fooddetails()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 170),
                    child: Text("Food details",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>moneydetails()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: Text("Bank",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>adminorderview()));
              },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 170),
                    child: Text("Order Details",style: GoogleFonts.share(fontSize: 20),),
                  )),
            ),
          ],
        ),
      ),
    );
  }
  exit() async{
    final pref=await SharedPreferences.getInstance();
    //pref.clear();
    pref.remove('id');
  }
}
