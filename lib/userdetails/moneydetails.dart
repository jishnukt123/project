import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/craft.dart';
import 'package:hope/userdetails/moneyinsert.dart';
import 'package:hope/userdetails/moneyupdate.dart';

import '../userdetails/moneyview.dart';
import 'package:http/http.dart' as http;

class moneydetails extends StatefulWidget {
  final model data;
 // const moneydetails({Key? key}) : super(key: key);
  moneydetails({required this.data});

  @override
  State<moneydetails> createState() => _moneydetailsState();
}

class _moneydetailsState extends State<moneydetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Welcome"),
        actions: [
          InkWell(child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.delete),
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Delete?"),
                actions: [
                  ElevatedButton(
                      onPressed: (){Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  ElevatedButton(onPressed: (){
                    delete(widget.data.id);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyview()));
                  },
                      child: Text("Delete"))
                ],
              );
            });
          },)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 200,
                width: 300,
                child: Image.asset("assets/images/bank.jpg"),
              ),
            ),
            Container(
              height: 400,
              width: 200,
              //color: Colors.blue,
              child: Column(
                children: [
                 // SizedBox(height: 10,),
                  Text(widget.data.name,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  Text(widget.data.place,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  Text(widget.data.phone,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  Text(widget.data.amount,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  Text(widget.data.account,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  Text(widget.data.bank,style: GoogleFonts.alegreyaSc(fontSize: 30),),
                  SizedBox(height: 10,),
                  OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyupdate(id:widget.data.id,name:widget.data.name,place:widget.data.place,phone:widget.data.phone,amount:widget.data.amount,bank:widget.data.bank,account:widget.data.account)));
                  },
                      child: Text("Edit",style: GoogleFonts.amiri(fontSize: 20),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  delete(String id) async{
    var api="http://192.168.29.92/hope/user/moneydelete.php";
    http.Response response=await http.post(Uri.parse(api),body: {'Id':id});
  }
}
