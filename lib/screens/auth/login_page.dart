import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/widget/ThemeLogin/theme_helper.dart';

import 'package:flutter_login_ui/backend/authntification/authntification_serivice.dart';
import 'package:flutter_login_ui/screens/header/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final String assetName = 'assets/svg/login.svg';

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizeOfScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(
                    20, 10, 20, 10), // This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Log in',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Login to you account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    SvgPicture.asset(
                      'assets/svg/login.svg',
                      height: sizeOfScreen.height / 5,
                    ),
                    SizedBox(height: 30.0),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: email,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Email', 'Enter Your Email'),
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Password', 'Enter Your Password'),
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage()),
                                  );
                                },
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                AuthenticationService().signIn(
                                    email: email.text,
                                    password: password.text,
                                    context: context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: sizeOfScreen.height / 20,
                                width: sizeOfScreen.width,
                                decoration: BoxDecoration(
                                  color: Color(0xff189AB4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(TextSpan(children: [
                                TextSpan(text: 'Don\'t have an account?'),
                                TextSpan(
                                  text: 'Register',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationPage()));
                                    },
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ),
                              ])),
                            ),
                          ],
                        )),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 1.0,
                          width: 130.0,
                          color: Colors.grey,
                        ),
                        Text(
                          'or',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          height: 1.0,
                          width: 130.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    // Text(
                    //   "create account using social media",
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                    SizedBox(height: 25.0),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 5, color: HexColor("#EC2D2F")),
                              color: HexColor("#EC2D2F"),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.google,
                              size: 25,
                              color: HexColor("#FFFFFF"),
                            ),
                          ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Text(
                            "Login with Google",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ThemeHelper().alartDialog("Twitter",
                                  "You tap on Twitter social icon.jj", context);
                            },
                          );
                        });
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
