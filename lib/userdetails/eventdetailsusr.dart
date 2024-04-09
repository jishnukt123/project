import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hope/userdetails/eventviewusr.dart';
import 'package:hope/userdetails/view_events.dart';

class eventdetailsusr extends StatefulWidget {
  final model data;
 // const eventdetailsusr({Key? key}) : super(key: key);
  eventdetailsusr({required this.data});

  @override
  State<eventdetailsusr> createState() => _eventdetailsusrState();
}

class _eventdetailsusrState extends State<eventdetailsusr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Event Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children:[ Container(
                height: 500,
                width: 300,
                child: Column(
                  children: [
                    Image.asset("assets/images/2ba6fd817cda439c479f435ef02bf3a4.jpg",fit: BoxFit.fill,),
                    SizedBox(height: 10,),
                    Container(
                      child: Column(
                        children: [
                          //Text(widget.data.id,style: TextStyle(color: Colors.black,fontSize: 20)),
                          Text(widget.data.name,style: GoogleFonts.aladin(color: Colors.black,fontSize: 30,)),
                          SizedBox(height: 10,),
                          Text(widget.data.description,style: GoogleFonts.aladin(color: Colors.black,fontSize: 30)),
                          SizedBox(height: 10,),
                          Text(widget.data.date,style: GoogleFonts.aladin(color: Colors.black,fontSize: 30)),
                          SizedBox(height: 10,),
                          Text(widget.data.time,style: GoogleFonts.aladin(color: Colors.black,fontSize: 30)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
            // Container(
            //     // height: 100,
            //     // width: 100,
            //     child: Column(
            //       children: [
            //         Text(widget.data.id,style: TextStyle(color: Colors.black,fontSize: 20),),
            //         Text(widget.data.name,style: TextStyle(color: Colors.black,fontSize: 20),),
            //         Text(widget.data.description,style: TextStyle(color: Colors.black,fontSize: 20),),
            //         Text(widget.data.date,style: TextStyle(color: Colors.black,fontSize: 20),),
            //         Text(widget.data.time,style: TextStyle(color: Colors.black,fontSize: 20),)
            //       ],
            //     ),
            //   ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   color: Colors.grey,
            //   child: Column(
            //     children: [
            //       SizedBox(height: 20,),
            //       Text(widget.data.id,style: TextStyle(fontSize: 20),),
            //       Text(widget.data.name,style: TextStyle(fontSize: 20)),
            //       Text(widget.data.description,style: TextStyle(fontSize: 20)),
            //       Text(widget.data.date,style: TextStyle(fontSize: 20)),
            //       Text(widget.data.time,style: TextStyle(fontSize: 20)),
            //       // ElevatedButton(onPressed: (){
            //       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>usereventedit(id:widget.data.id,name:widget.data.name,description:widget.data.description,date:widget.data.date,time:widget.data.time)));
            //       // },
            //       //     child: Text("Edit"))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
