import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/deleteuserevent.dart';
// import 'package:hope/userdetails/eventdetailsusr.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class model{
  late final String id;
  late final String name;
  late final String description;
  late final String date;
  late final String time;
  model({required this.id,required this.name,required this.description,required this.date,required this.time});
}

class eventviewusr extends StatefulWidget {

  const eventviewusr({Key? key}) : super(key: key);

  @override
  State<eventviewusr> createState() => _eventviewusrState();
}

class _eventviewusrState extends State<eventviewusr> {
  Future<List<model>> getdata() async{
    final pref=await SharedPreferences.getInstance();
    var abc=pref.getString('user_id');
    var api="http://192.168.29.92/hope/user/usereventview.php?id="+abc!;
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata)
      {
        model users=model(
            id: singleuser['Id'].toString(),
            name: singleuser['Name'].toString(),
            description: singleuser['Description'].toString(),
            date: singleuser['Date'].toString(),
            time: singleuser['Time'].toString()
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
        title: Text("Event details"),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (BuildContext ctx,AsyncSnapshot snapshot){
            if(snapshot.data==null)
              {
                return Center(child: Text("No data found.."));
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
                            tileColor: Colors.green.shade300,
                            title: Center(child: Text(snapshot.data[index].name,style: GoogleFonts.amiri(color: Colors.white,fontSize: 20),)),
                            subtitle: Center(child: Text(snapshot.data[index].description,style: GoogleFonts.amiri(color: Colors.white,fontSize: 20),)),

                            trailing: GestureDetector(child: Icon(Icons.navigate_next_sharp,color: Colors.white,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>deleteuserevent(data:snapshot.data[index])));
                            },),
                          ),
                        )
                      ],
                    ));
              }
          }

      ),
    );
  }
}
