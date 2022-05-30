import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_ui/backend/submit_complain/submit_complain.dart';
import 'package:flutter_login_ui/models/listOfDistricts.dart';
import 'package:flutter_login_ui/providers/location.dart';
import 'package:flutter_login_ui/screens/map/map_screen.dart';
import 'package:flutter_login_ui/screens/notification/notification_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MakeComplaint extends StatefulWidget {
  const MakeComplaint({Key? key}) : super(key: key);

  @override
  State<MakeComplaint> createState() => _MakeComplaintState();
}

class _MakeComplaintState extends State<MakeComplaint> {
  String? title;
  String? description;
  String? type;
  String? department;
  String? address;

  String? latitude;
  String? longitude;

  File? selectedImage;
  VideoPlayerController? _controller;
  // MediaType _mediaType = MediaType.image;

  List<String> list = ["RDA", "waterboard", "Electricity Board"];
  List<String> districtList1 = [
    "Colombo",
    "Gampaha",
    "Kalutara",
    "Kandy",
    "Matale",
    "Nuwara Eliya",
    "Galle",
    "Matara",
    "Hambantota",
    "Jaffna",
    "Kilinochchi",
    "Mannar",
    "Vavuniya",
    "Mullaitivu",
    "Batticaloa",
    "Ampara",
    "Trincomalee",
    "Kurunegala",
    "Puttalam",
    "Anuradhapura",
    "Polonnaruwa",
    "Badulla",
    "Moneragala",
    "Ratnapura",
    "Kegalle",
  ];
  String? selectedItem = 'RDA';
  String selectedDistrict = "Colombo";

  //function for getting current location

  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();

  final TextEditingController _districtController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    //  Provider.of<MakeComplainant>(context, listen: false).setPosition(
    //     null,
    //     null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Make the complaint"),
          backgroundColor: HexColor('#75b9e6'),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        ),
                    icon: Icon(Icons.notifications_outlined)))
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Form(child: )

                Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          labelText: 'Title', border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter a title';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter a title';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // TextFormField(
                    //   controller: _districtController,
                    //   // maxLines: 4,
                    //   decoration: InputDecoration(
                    //       labelText: 'District', border: OutlineInputBorder()),
                    //   validator: (val) {
                    //     if (val!.isEmpty) {
                    //       return 'Please enter a title';
                    //     } else
                    //       return null;
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Select District",
                          style: TextStyle(fontSize: 18),
                        ),
                        DropdownButton<String>(
                          value: selectedDistrict,
                          items: districtList1.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedDistrict = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  }),
                  child: Container(
                    child: Text(
                      "Select the Location",
                      style: TextStyle(fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    height: size.height / 20,
                    // width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff75b9e6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select the Department : ",
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<String>(
                      value: selectedItem,
                      items: list.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedItem = val;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  "Input a Image or video",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: () => pickImageOrVideo(ImageSource.gallery),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 60),
                              Text("Gallery")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(5)),
                        child: InkWell(
                          onTap: () => pickImageOrVideo(ImageSource.camera),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_enhance, size: 60),
                              Text("Camera")
                            ],
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                selectedImage != null
                    ? Stack(children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        Container(
                          child: Image.file(
                            selectedImage!,
                            width: 160,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ])
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    final latt =
                        Provider.of<MakeComplainant>(context, listen: false)
                            .lat;
                    final longg =
                        Provider.of<MakeComplainant>(context, listen: false)
                            .long;

                    final submit = await SubmitComplain().submitAComplain(
                        _titleController.text,
                        _descriptionController.text,
                        selectedDistrict,
                        longg!,
                        latt!,
                        selectedImage,
                        selectedItem);
                    CircularProgressIndicator();
                    if (submit == "Success")
                      Navigator.of(context).pop();
                    else
                      AlertDialog(
                        title: Text(submit!),
                      );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 20,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff75b9e6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  Future pickImageOrVideo(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.selectedImage = imageTemporary;
      });
    } catch (e) {
      print(e);
    }
  }

  Future pickVideo(ImageSource source) async {
    try {
      final image = await ImagePicker().pickVideo(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.selectedImage = imageTemporary;
        this._controller = imageTemporary as VideoPlayerController?;
      });
    } catch (e) {
      print(e);
    }
  }
}
