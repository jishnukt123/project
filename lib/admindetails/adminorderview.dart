import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/admindetails/adminorderdetails.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class model{
  late final String id;
  late final String username;
  late final String phone;
  late final String total;
  model({required this.id,required this.username,required this.phone,required this.total});
}
class adminorderview extends StatefulWidget {
  const adminorderview({Key? key}) : super(key: key);

  @override
  State<adminorderview> createState() => _adminorderviewState();
}

class _adminorderviewState extends State<adminorderview> {
  Future<List<model>> getdata() async{
    final pref= await SharedPreferences.getInstance();
    //var a=pref.getString('user_id');
    var api="http://192.168.29.92/hope/admin/adminorderview.php";
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata){
      model users=model(
        id: singleuser['Id'].toString(),
        username: singleuser['Username'].toString(),
        phone: singleuser['Phone'].toString(),
        total: singleuser['Total'].toString(),
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
        title: Text("Order details"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext ctx,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(child: Text("No data found"));
            }
            else{
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 500,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("Name",style: TextStyle(fontSize: 20,color: Colors.black),),
                              SizedBox(width: 40,),
                              Text("Phone",style: TextStyle(fontSize: 20,color: Colors.black),),
                              SizedBox(width: 40,),
                              Text("Total",style: TextStyle(fontSize: 20,color: Colors.black),),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx,index)=>Column(
                            children: [
                              Container(
                                height: 80,
                                width: 400,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  color: Colors.blue.shade300,
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                         Text(snapshot.data[index].username),
                                          SizedBox(width: 30,),
                                          Text(snapshot.data[index].phone),
                                          SizedBox(width: 40,),
                                          Text(snapshot.data[index].total),
                                          SizedBox(width: 40,),
                                          ElevatedButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>adminorderdetails()));
                                          },
                                              child: Text("Details"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
