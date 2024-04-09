import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class craft extends StatefulWidget {
  const craft({Key? key}) : super(key: key);

  @override
  State<craft> createState() => _craftState();
}
TextEditingController craft_id=TextEditingController();
TextEditingController name=TextEditingController();
TextEditingController price=TextEditingController();
TextEditingController description=TextEditingController();
class _craftState extends State<craft> {
  var image;
  var image_path;
  var img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter id",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    controller: craft_id,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: name,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter price",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: price,
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: description,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Select image :",style: GoogleFonts.aladin(fontSize: 30,color: Colors.white),),
                      IconButton(onPressed: (){
                        select();
                        print(img);
                      },
                          icon: Icon(Icons.image,color: Colors.white,)),
                      IconButton(onPressed: (){
                        add();
                      }
                          , icon: Icon(Icons.camera_alt,color: Colors.white,)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: img!=null?Image.file(img):Center(child: Text("No image"),)

                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    insert();
                  },
                      child: Text("Insert")),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  select() async{
    try{
      final image=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)return;
      final image_path=File(image.path);
      setState(() {
        this.img=image_path;


        print(img);
      });
    }
    on PlatformException catch(e)
    {
      print("Failed to pick image");
    }
  }
add() async{
    try{
      final image=await ImagePicker().pickImage(source: ImageSource.camera);
      if(image==null) return;
      final image_path=File(image.path);
      setState(() {
        this.img=image_path;
      });
    }
    on PlatformException catch(e)
  {
    print("Failed to pick image");
  }
}
insert() async{
    var api="http://192.168.29.92/hope/admin/admincraft.php";
    var request=http.MultipartRequest('post',Uri.parse(api));
    request.fields['Craft_id']=craft_id.text;
    request.fields['Name']=name.text;
    request.fields['Price']=price.text;
    request.fields['Description']=description.text;
    var sel=await http.MultipartFile.fromPath('Image',img.path);
    request.files.add(sel);
    var response=request.send();
}
}
