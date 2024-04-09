import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminprofile extends StatefulWidget {
  const adminprofile({Key? key}) : super(key: key);

  @override
  State<adminprofile> createState() => _adminprofileState();
}
var name;
var email;
var phone;
class _adminprofileState extends State<adminprofile> {
  @override
  void initState() {
    details();
    // TODO: implement initState
    super.initState();
  }
  details() async{
    final pref=await SharedPreferences.getInstance();
    name=pref.getString('username');
    email=pref.getString('email');
    phone=pref.getString('phone');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: 400,
              color: Colors.white,
              child:Image.asset("assets/images/pngtree-blue-sky-white-clouds-hill-cartoon-picture-image_943773.jpg",fit: BoxFit.fill,),
            ),
          ),
          Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Name  :",style: GoogleFonts.aladin(fontSize: 30),),
                    Text(name,style: TextStyle(fontSize: 20),),
                  ],
                ),
                Row(
                  children: [
                    Text("Email   :",style: GoogleFonts.aladin(fontSize: 30),),
                    Text(email,style: TextStyle(fontSize: 20),),
                  ],
                ),
                Row(
                  children: [
                    Text("Phone  :",style: GoogleFonts.aladin(fontSize: 30),),
                    Text(phone,style: TextStyle(fontSize: 20),),
                  ],
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Text("Email   :",style: GoogleFonts.aladin(fontSize: 30),),
          //     Text(email,style: TextStyle(fontSize: 20),),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Text("Phone  :",style: GoogleFonts.aladin(fontSize: 30),),
          //     Text(phone,style: TextStyle(fontSize: 20),),
          //   ],
          // ),
        ],

      ),
    );
  }
}
