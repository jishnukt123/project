import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userview extends StatefulWidget {
  const userview({Key? key}) : super(key: key);

  @override
  State<userview> createState() => _userviewState();
}
var Name;
var Email;
var Phone;
class _userviewState extends State<userview> {
  @override
  void initState() {
    details();
    // TODO: implement initState
    super.initState();
  }
  details() async{
    final pref=await SharedPreferences.getInstance();
    Name=pref.getString('uname');
    Email=pref.getString('uemail');
    Phone=pref.getString('uphone');

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/tree-736885_1280.jpg",fit: BoxFit.fill,),
              ),
              Container(
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Icon(Icons.person_pin,size: 70,),
                    SizedBox(height: 20,),
                    Text(Name,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                    SizedBox(height: 20,),
                    Text(Email,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                    SizedBox(height: 20,),
                    Text(Phone,style: GoogleFonts.alegreyaSc(fontSize: 30),),


                  ],
                ),

                //child: Text(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
