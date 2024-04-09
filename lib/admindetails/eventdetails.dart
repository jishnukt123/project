import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hope/admindetails/viewevent.dart';

class eventdetails extends StatefulWidget {
  final model data;
  //const eventdetails({Key? key}) : super(key: key);
  eventdetails({required this.data});

  @override
  State<eventdetails> createState() => _eventdetailsState();
}

class _eventdetailsState extends State<eventdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 400,
            child:Image.asset("assets/images/original-2b111fe70e25678f3b42485f4b43f556.jpg")
          ),
          // Row(
          //   children: [
          //     Text("Id     :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //     Text(widget.data.id,style: TextStyle(fontSize: 20,color: Colors.black),),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Name  :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(widget.data.name,style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Description  :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(widget.data.description,style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Date    :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(widget.data.date,style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  ), SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Time   :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(widget.data.time,style: TextStyle(fontSize: 20,color: Colors.black),),
                    ],
                  )
                ],
              ),
            ),
          ),
          // SizedBox(height: 10,),
          //   Row(
          //       children: [
          //         Text("Name  :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //         Text(widget.data.name,style: TextStyle(fontSize: 20,color: Colors.black),),
          //       ],
          //     ),
          // SizedBox(height: 10,),
          //     Row(
          //       children: [
          //         Text("Description  :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //         Text(widget.data.description,style: TextStyle(fontSize: 20,color: Colors.black),),
          //       ],
          //     ),
          // SizedBox(height: 10,),
          //     Row(
          //       children: [
          //         Text("Date    :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //         Text(widget.data.date,style: TextStyle(fontSize: 20,color: Colors.black),),
          //       ],
          //     ), SizedBox(height: 10,),
          //     Row(
          //       children: [
          //         Text("Time   :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //         Text(widget.data.time,style: TextStyle(fontSize: 20,color: Colors.black),),
          //       ],
          //     )
        ],
      )
    );
  }
}
