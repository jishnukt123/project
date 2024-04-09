import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class model{
  late final String image;
  late final String quantity;
  late final String price;
  model({required this.image,required this.quantity,required this.price});
}

class adminorderdetails extends StatefulWidget {
  const adminorderdetails({Key? key}) : super(key: key);

  @override
  State<adminorderdetails> createState() => _adminorderdetailsState();
}

class _adminorderdetailsState extends State<adminorderdetails> {
  Future<List<model>> getdata() async
  {
    final pref= await SharedPreferences.getInstance();
    var a=pref.getString('user_id');
    var api="http://192.168.29.92/hope/admin/adminorderdetails.php?id="+a!;
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata)
      {
        model users=model(
          image: singleuser['Image'],
          quantity: singleuser['Quantity'].toString(),
          price: singleuser['Price'].toString()
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
      body: Container(
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext ctx,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(child: Text("No data..."));
            }
            else
              {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: 400,
                        color: Colors.blue.shade400,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,height: 10,),
                                Text("Image",style: GoogleFonts.amiri(fontSize: 20,color: Colors.white),),
                                SizedBox(width: 50,),
                                Text("Quantity",style: GoogleFonts.amiri(fontSize: 20,color: Colors.white),),
                                SizedBox(width: 50,),
                                Text("Price",style: GoogleFonts.amiri(fontSize: 20,color: Colors.white),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx,index)=> Column(
                            children: [
                              Container(
                                height: 70,
                                width: 400,
                                color: Colors.blue.shade100,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(snapshot.data[index].image)
                                              )
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 50,),
                                        Text(snapshot.data[index].quantity),
                                        SizedBox(width: 90,),
                                        Text(snapshot.data[index].price)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ))
                  ],
                );
              }
          },
        ),
      ),
    );
  }
}
