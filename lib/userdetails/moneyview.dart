import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/moneydetails.dart';
import 'package:http/http.dart' as http;
class model{
  late final String id;
  late final String name;
  late final String place;
  late final String phone;
  late final String amount;
  late final String bank;
  late final String account;
  model({required this.id,required this.name,required this.place,required this.phone,required this.amount,required this.bank,required this.account});
}
class moneyview extends StatefulWidget {
  const moneyview({Key? key}) : super(key: key);

  @override
  State<moneyview> createState() => _moneyviewState();
}

class _moneyviewState extends State<moneyview> {
  Future<List<model>> getdata() async{
    var api="http://192.168.29.92/hope/user/moneyview.php";
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata)
      {
        model users=model(
          id:singleuser['Id'].toString(),
          name:singleuser['Name'].toString(),
          place: singleuser['Place'].toString(),
          phone:singleuser['Phone'].toString(),
          amount: singleuser['Amount'].toString(),
          bank: singleuser['Bank'].toString(),
          account: singleuser['Account'].toString()
        );
        user.add(users);
      }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bank details"),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (BuildContext ctx,AsyncSnapshot snapshot)
        {
          if(snapshot.data==null)
            {
              return Center(child: Text("No data found"));
            }
          else
            {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx,index)=>
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      leading: Icon(Icons.person,size: 40,color: Colors.white,),
                      tileColor: Colors.green.shade300,
                      title: Center(child: Text(snapshot.data[index].name,style: GoogleFonts.aladin(color: Colors.white,fontSize: 20),)),
                      subtitle: Center(child: Text(snapshot.data[index].place,style: GoogleFonts.aladin(color: Colors.white,fontSize: 20),)),
                      trailing: InkWell(child: Icon(Icons.navigate_next_sharp,color: Colors.white,size: 40,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>moneydetails(data:snapshot.data[index])));
                      },),
                    ),
                  )
                ],
              ));
            }
        },
      ),
    );
  }
}
