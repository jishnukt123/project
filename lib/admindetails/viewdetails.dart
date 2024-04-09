import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/admindetails/view.dart';
import 'package:http/http.dart' as http;
class model{
  late final String id;
  late final String name;
  late final String price;
  late final String description;
  late final String image;
  model({required this.id,required this.name,required this.price,required this.description,required this.image});
}
class viewdetails extends StatefulWidget {
  const viewdetails({Key? key}) : super(key: key);

  @override
  State<viewdetails> createState() => _viewdetailsState();
}

class _viewdetailsState extends State<viewdetails> {
  Future<List<model>> getdata() async{
    var api="http://192.168.29.92/hope/admin/adminview.php";
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata)
      {
        model users=model(
          id: singleuser['Id'].toString(),
          name: singleuser['Name'].toString(),
          price: singleuser['Price'].toString(),
          description: singleuser['Description'].toString(),
          image:singleuser['Image'],
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
        builder: (BuildContext ctx,AsyncSnapshot snapshot){
          if(snapshot.data!=null){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx,index)=>Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1),
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data[index].image),
                                  fit: BoxFit.fill

                                ),
                                //borderRadius: BorderRadius.circular(20)
                            ),
                            // child: Image.network(snapshot.data[index].image,fit: BoxFit.fill,),
                          ),
                          tileColor: Colors.blue.shade200,
                          title: Center(child: Text(snapshot.data[index].name,style: GoogleFonts.aladin(color: Colors.white,fontSize: 20),)),
                          subtitle: Center(child: Text(snapshot.data[index].description,style: GoogleFonts.aladin(color: Colors.white,fontSize: 20),)),
                          trailing: InkWell(child: Icon(Icons.navigate_next_sharp,color: Colors.white,size: 30,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>view(data:snapshot.data[index])));
                            },),
                        ),
                      )],
                  )
              );
          }
          else
            {
              return Center(child: Text("No data found"));
            }
        },
      ),
    );
  }
}
