import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../admindetails/moneydetails.dart';

class moneyviewadmin extends StatefulWidget {
  final model data;
  //const moneyviewadmin({Key? key}) : super(key: key);
  moneyviewadmin({required this.data});

  @override
  State<moneyviewadmin> createState() => _moneyviewadminState();
}

class _moneyviewadminState extends State<moneyviewadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              child: Image.asset("assets/images/tree-736885_1280.jpg"),
            ),
            Container(
              height: 250,
              width: 200,
              color: Colors.blue.shade300,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(widget.data.name,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 5,),
                  Text(widget.data.place,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 5,),
                  Text(widget.data.phone,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 5,),
                  Text(widget.data.amount,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 5,),
                  Text(widget.data.bank,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                  SizedBox(height: 5,),
                  Text(widget.data.account,style: GoogleFonts.amiri(fontSize: 20,color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
