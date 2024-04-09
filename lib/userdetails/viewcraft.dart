import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/details.dart';
import 'package:http/http.dart' as http;

class model{
  late final String id;
  late final String name;
  late final String price;
  late final String description;
  late final String image;
  model({required this.id,required this.name,required this.price,required this.description,required this.image});
}

class viewcraft extends StatefulWidget {

  const viewcraft({Key? key}) : super(key: key);

  @override
  State<viewcraft> createState() => _viewcraftState();
}

class _viewcraftState extends State<viewcraft> {
  Future<List<model>> getdata() async{
    var api="http://192.168.29.92/hope/admin/adminview.php";
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata){
      model users=model(
        id: singleuser['Id'].toString(),
        name: singleuser['Name'].toString(),
        price: singleuser['Price'].toString(),
        description: singleuser['Description'].toString(),
        image: singleuser['Image'],
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
        title: Text("Craft Details"),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (BuildContext ctx,AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Center(child: Text("No data found"));
          }
          else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx,index)=>Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        tileColor: Colors.green.shade100,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 0),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(snapshot.data[index].image,),
                            )
                          ),
                        ),
                        title: Center(child: Text(snapshot.data[index].name,style: GoogleFonts.amiri(fontSize: 20),)),
                        subtitle: Center(child: Text(snapshot.data[index].price,style: GoogleFonts.amiri(fontSize: 20),)),
                        trailing: InkWell(child: Icon(Icons.navigate_next),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>details(data: snapshot.data[index])));
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
