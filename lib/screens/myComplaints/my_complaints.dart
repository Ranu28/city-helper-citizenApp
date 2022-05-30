import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyComplaintScreen extends StatefulWidget {
  const MyComplaintScreen({Key? key}) : super(key: key);

  @override
  State<MyComplaintScreen> createState() => _MyComplaintScreenState();
}

class _MyComplaintScreenState extends State<MyComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Complaints"),
        backgroundColor: HexColor('#75b9e6'),
      ),
      body: Container(
        child: Column(children: [
          Container(
            child: Column(),
          ),
        ]),
      ),
    );
  }
}
