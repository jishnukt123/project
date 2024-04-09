import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/admindetails/foodview.dart';
import 'package:http/http.dart' as http;

class model{
  late final String id;
  late final String date;
  late final String name;
  late final String food;
  model({required this.id,required this.date,required this.name,required this.food});
}

class fooddetails extends StatefulWidget {
  const fooddetails({Key? key}) : super(key: key);
  @override
  State<fooddetails> createState() => _fooddetailsState();
}

class _fooddetailsState extends State<fooddetails> {
  Future<List<model>> getdata() async{
    var api="http://192.168.29.92/hope/user/foodview.php";
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata)
      {
        model users=model(
          id:singleuser['Id'].toString(),
          date:singleuser['Date'].toString(),
          name:singleuser['Name'].toString(),
          food: singleuser['Food_type'].toString(),
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
        title: Text("Food details"),
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
                  itemBuilder: (ctx,index)=>Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          leading: Icon(Icons.person,size: 30,color: Colors.white),
                          tileColor: Colors.blue.shade400,
                          title: Center(child: Text(snapshot.data[index].name,style: TextStyle(color: Colors.white,fontSize: 20),)),
                          subtitle: Center(child: Text(snapshot.data[index].food,style: TextStyle(color: Colors.white,fontSize: 20),)),
                          trailing: InkWell(child: Icon(Icons.navigate_next_sharp,color: Colors.white,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>foodview(data:snapshot.data[index])));
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
