import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/admindetails/eventdetails.dart';
import 'package:http/http.dart' as http;

class model{
  late final String id;
  late final String name;
  late final String description;
  late final String date;
  late final String time;
  model({required this.id,required this.name,required this.description,required this.date,required this.time});
}

class viewevent extends StatefulWidget {
  const viewevent({Key? key}) : super(key: key);

  @override
  State<viewevent> createState() => _vieweventState();
}

class _vieweventState extends State<viewevent> {
  Future<List<model>> getdata() async
  {
    var api="http://192.168.29.92/hope/admin/admineventview.php";
    http.Response response=await http.post(Uri.parse(api))as http.Response;
    var responseddata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responseddata){
      model users=model(
        id:singleuser['Id'].toString(),
        name:singleuser['Name'].toString(),
        description: singleuser['Description'].toString(),
        date: singleuser['Date'].toString(),
        time: singleuser['Time'].toString(),
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
        title: Text("Event details"),
      ),
      body: FutureBuilder(
        future: getdata(),
          builder: (BuildContext ctx,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Center(child: Text("No data found"));
          }
          else
            {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx,index)=>Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          leading: Icon(Icons.event,size: 30,color: Colors.white,),
                         tileColor: Colors.blue.shade300,
                          title: Center(child: Text(snapshot.data[index].name,style: TextStyle(color: Colors.white,fontSize: 20),)),
                          subtitle: Center(child: Text(snapshot.data[index].date,style: TextStyle(color: Colors.white,fontSize: 20),)),
                          trailing: InkWell(child: Icon(Icons.navigate_next_sharp,size: 30,color: Colors.white),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>eventdetails(data:snapshot.data[index])));
                          },),
                        ),
                      )
                    ],
                  )
              );
            }
          }),
    );
  }
}
