import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../admindetails/fooddetails.dart';

class foodview extends StatefulWidget {
  final model data;
  //const foodview({Key? key}) : super(key: key);
  foodview({required this.data});

  @override
  State<foodview> createState() => _foodviewState();
}

class _foodviewState extends State<foodview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset("assets/images/foodn.jpg",fit: BoxFit.fill,),
            ),
            SizedBox(height: 20,),
            Container(
              height: 200,
              width: 300,
              //color: Colors.pink,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Id  :",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      Text(widget.data.id,style: TextStyle(fontSize: 30),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Date  :",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                      Text(widget.data.date,style: TextStyle(fontSize: 30),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Name  :",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                      Text(widget.data.name,style: TextStyle(fontSize: 30),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Food type  :",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                      Text(widget.data.food,style: TextStyle(fontSize: 30),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
