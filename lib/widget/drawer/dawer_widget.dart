import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/myComplaints/my_complaints.dart';
import 'package:flutter_login_ui/screens/notification/notification_screen.dart';
import 'package:flutter_login_ui/screens/profileDetails/profile_details.dart';
import 'package:hexcolor/hexcolor.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
          child: Column(
        children: [
          Container(
            height: size.height / 3,
            width: size.width,
            decoration: BoxDecoration(color: HexColor('#75b9e6')),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ranu Pathiranage",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                user.email!,
                style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            ]),
          ),
          ListView(
            padding: EdgeInsets.only(left: 20, top: 40),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("My Profile"),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.pending),
                title: Text("My Complaints"),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MyComplaintScreen()),
                  ),
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Divider(color: HexColor('#75b9e6'), height: 4),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sign out"),
                  onTap: () => {
                    FirebaseAuth.instance.signOut(),
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class buildItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function onTapFunction;
  const buildItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTapFunction(),
    );
  }
}
