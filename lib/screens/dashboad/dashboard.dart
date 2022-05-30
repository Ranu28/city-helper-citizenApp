import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/backend/authntification/chechUser.dart';
import 'package:flutter_login_ui/backend/provinces_and_cities/call_api.dart';
import 'package:flutter_login_ui/models/cities.dart';
import 'package:flutter_login_ui/models/districts.dart';
import 'package:flutter_login_ui/models/news.dart';
import 'package:flutter_login_ui/models/provinces.dart';
import 'package:flutter_login_ui/screens/makeComlaint/make_complaint.dart';
import 'package:flutter_login_ui/screens/notification/notification_screen.dart';
import 'package:flutter_login_ui/widget/drawer/dawer_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({Key? key}) : super(key: key);

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  final user = FirebaseAuth.instance.currentUser!;
  final items = ['item1', 'item2', "item3"];
  String? value;
  String dropdownValue = 'Select your province';
  List<Provinces>? province;
  List<Cities>? cities;
  List<Districts>? districts;
  Provinces? selectedProvince;
  late List<Districts> districtsPovince;
  bool isEmptyDistrict = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    province = await ApiForCities().getProvince();
    cities = await ApiForCities().getCities();
    districts = await ApiForCities().getDistricts();

    // print(province![0].nameEn);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        backgroundColor: HexColor('#75b9e6'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MakeComplaint())),
                  child: Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: size.width,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade200.withOpacity(0.5)),
                          child: Center(
                              child: Text(
                            "Make a new Complaint",
                            style: TextStyle(fontSize: 30),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "News",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<List<News>?>(
                        stream: getNews(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error");
                          }
                          ;
                          if (snapshot.hasData) {
                            final newsList = snapshot.data!;
                            return ListView.separated(
                                reverse: false,
                                controller: _scrollController,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                                itemCount: newsList.length,
                                itemBuilder: (context, int index) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsList[index].title!.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          newsList[index].description!,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              newsList[index].department!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${newsList[index].time!.toDate().day.toString()} - ${newsList[index].time!.toDate().month.toString()} - ${newsList[index].time!.toDate().year.toString()}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }
                          ;
                          if (!snapshot.hasData) {
                            return Text("no data");
                          }
                          ;
                          return Text("no data 2");
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));

  Stream<List<News>?> getNews() => FirebaseFirestore.instance
      .collection('News')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => News.fromJson(doc.data())).toList());
}
