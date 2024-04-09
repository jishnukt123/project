import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'moneyviewadmin.dart';

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
class moneydetails extends StatefulWidget {
  const moneydetails({Key? key}) : super(key: key);

  @override
  State<moneydetails> createState() => _moneydetailsState();
}

class _moneydetailsState extends State<moneydetails> {
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
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Details"),
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
                            leading: Icon(Icons.person_pin,size: 40,color: Colors.white,),
                            tileColor: Colors.blue.shade300,
                            title: Center(child: Text(snapshot.data[index].name,style: TextStyle(color: Colors.white),)),
                            subtitle: Center(child: Text(snapshot.data[index].place,style: TextStyle(color: Colors.white),)),
                            trailing: InkWell(child: Icon(Icons.navigate_next_sharp,color: Colors.white,),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>moneyviewadmin(data:snapshot.data[index])));
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
