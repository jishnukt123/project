import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/userdetails/payment_tb.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class model{
  late final String order_id;
  late final String price;
  late final String quantity;
  late final String image;
  model({required this.order_id,required this.price,required this.quantity,required this.image});
}
class orderview extends StatefulWidget {
  const orderview({Key? key}) : super(key: key);

  @override
  State<orderview> createState() => _orderviewState();
}
var r;
int amont=0;
class _orderviewState extends State<orderview> {
  Future<List<model>> getdata() async{
    final pref= await SharedPreferences.getInstance();
    var a=pref.getString('user_id');
    pref.getString('order_id');
    var api="http://192.168.29.92/hope/user/orderview.php?id="+a!;
    http.Response response=await http.post(Uri.parse(api)) as http.Response;
    var responsedata=jsonDecode(response.body);
    List<model> user=[];
    for(var singleuser in responsedata){
      model users=model(
        order_id: singleuser['Order_id'].toString(),
        price: singleuser['Price'].toString(),
        quantity: singleuser['Quantity'].toString(),
        image: singleuser['Image'],
      );
      user.add(users);
    }
    return user;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Order view"),
      ),
      body:Container(
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext ctx,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Center(child: Text("No data found"));
            }
            else{
              List<model> _user=snapshot.data;
              var amount=total_amount(_user);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.green.shade400,
                        borderRadius: BorderRadius.circular(20)
                      ),

                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              SizedBox(width: 25,),
                              Text("Image",style: GoogleFonts.allerta(fontSize: 20,color: Colors.white),),
                              SizedBox(width: 65,),
                              Text("Price",style: GoogleFonts.allerta(fontSize: 20,color: Colors.white),),
                              SizedBox(width: 60,),
                              Text("Quantity",style: GoogleFonts.allerta(fontSize: 20,color: Colors.white),)
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.green.shade100,
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 25,),
                                          Container(
                                            height: 40,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(snapshot.data[index].image),
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 80,),
                                          Text(snapshot.data[index].price,style: GoogleFonts.amiri(fontSize: 20),),
                                          SizedBox(width: 100,),
                                          Text(snapshot.data[index].quantity,style: GoogleFonts.amiri(fontSize: 20)),
                                          SizedBox(width: 30,),
                                          InkWell(child: Icon(Icons.delete),
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return AlertDialog(
                                                      backgroundColor: Colors.green.shade200,
                                                      title: Text("Delete..?"),
                                                      actions: [
                                                        ElevatedButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child: Text("Cancel")),
                                                        ElevatedButton(onPressed: (){
                                                          delete(snapshot.data[index].order_id);
                                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>orderview()));
                                                        },
                                                            child: Text("Ok"))
                                                      ],
                                                    );
                                                  });
                                            },),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Align(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 140,),
                            Text("Total :",style: TextStyle(fontSize: 20),),
                            Text("$amount",style: TextStyle(fontSize: 20),)
                          ],
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>payment_tb(total: amount)));
                        },
                            child: Text("Proceed to checkout"))
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),

    );
  }
  total_amount(List<model> _user)
  {
    double total=0.0;
    for(int i=0;i<_user.length;i++)
    {
      total=total+double.parse(_user[i].price);
    }
    return total.toString();
  }
  delete(String order_id) async{
    var api="http://192.168.29.92/hope/user/ordertbdelete.php";
    http.Response response=await http.post(Uri.parse(api),body: {'Id':order_id});
    var res=jsonDecode(response.body);
    if(res['status_code']==200)
    {
      Fluttertoast.showToast(msg: res['msg']);
    }
  }
}
