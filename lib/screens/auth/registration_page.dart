import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/widget/ThemeLogin/theme_helper.dart';

import 'package:flutter_login_ui/backend/authntification/authntification_serivice.dart';
import 'package:flutter_login_ui/screens/auth/login_page.dart';

import 'package:flutter_login_ui/screens/header/header_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

String? pss;

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  //controllers
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

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
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          'Create you account',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        SvgPicture.asset(
                          'assets/svg/register.svg',
                          height: sizeOfScreen.height / 5,
                        ),
                        // GestureDetector(
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           border:
                        //               Border.all(width: 5, color: Colors.white),
                        //           color: Colors.white,
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black12,
                        //               blurRadius: 20,
                        //               offset: const Offset(5, 5),
                        //             ),
                        //           ],
                        //         ),
                        //         child: Icon(
                        //           Icons.person,
                        //           color: Colors.grey.shade300,
                        //           size: 80.0,
                        //         ),
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                        //         child: Icon(
                        //           Icons.add_circle,
                        //           color: Colors.grey.shade700,
                        //           size: 25.0,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Container(
                        //   child: TextFormField(
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         'First Name', 'Enter your first name'),
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Container(
                        //   child: TextFormField(
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         'Last Name', 'Enter your last name'),
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        // SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if ((val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        // SizedBox(height: 20.0),
                        // Container(
                        //   child: TextFormField(
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         "Mobile Number", "Enter your mobile number"),
                        //     keyboardType: TextInputType.phone,
                        //     validator: (val) {
                        //       if ((val!.isEmpty) &&
                        //           !RegExp(r"^(\d+)*$").hasMatch(val)) {
                        //         return "Enter a valid phone number";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              pss = val.toString();
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),

                        Container(
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Confirm Password", "Confirm password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              } else if (val != pss) {
                                return "password is not match";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        // SizedBox(height: 15.0),
                        // Container(
                        //   decoration: ThemeHelper().buttonBoxDecoration(context),
                        //   child: ElevatedButton(
                        //     style: ThemeHelper().buttonStyle(),
                        //     child: Padding(
                        //       padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        //       child: Text(
                        //         "Register".toUpperCase(),
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       if (_formKey.currentState!.validate()) {
                        //         Navigator.of(context).pushAndRemoveUntil(
                        //             MaterialPageRoute(
                        //                 builder: (context) => ProfilePage()
                        //             ),
                        //                 (Route<dynamic> route) => false
                        //         );
                        //       }
                        //     },
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AuthenticationService().signUP(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // width: sizeOfScreen.width,
                            height: sizeOfScreen.height / 20,
                            width: sizeOfScreen.width,
                            decoration: BoxDecoration(
                              color: Color(0xff189AB4),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),

                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: Text('Don\'t have an account? Create'),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don\'t have an account? "),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            ),
                          ])),
                        ),
                        SizedBox(height: 10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1.0,
                              width: 130.0,
                              color: Colors.grey,
                            ),
                            Text(
                              "Or",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 5, color: HexColor("#EC2D2F")),
                                  color: HexColor("#EC2D2F"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 50,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  size: 50,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 5, color: HexColor("#3E529C")),
                                  color: HexColor("#3E529C"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  size: 50,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
