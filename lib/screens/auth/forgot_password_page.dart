import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/header/header_widget.dart';
import 'package:flutter_login_ui/widget/ThemeLogin/theme_helper.dart';
import 'package:flutter_svg/svg.dart';

import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailContoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizeOfScreen = MediaQuery.of(context).size;
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We will send you a verification code to your email.',
                              style: TextStyle(
                                color: Colors.black38,
                                // fontSize: 20,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SvgPicture.asset(
                        'assets/svg/forget.svg',
                        height: sizeOfScreen.height / 5,
                      ),
                      SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                controller: _emailContoller,
                                decoration: ThemeHelper().textInputDecoration(
                                    "Email", "Enter your email"),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Email can't be empty";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 40.0),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  print(_emailContoller.text);
                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _emailContoller.text);
                                    showDialog(
                                      context: context,
                                      builder: (context) => Center(
                                        child: Text(
                                            "We have send you an email to ${_emailContoller.text}. (Check on spam also.)"),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Center(
                                        child: Text(e.message!),
                                      ),
                                    );
                                  }
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
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   decoration:
                            //       ThemeHelper().buttonBoxDecoration(context),
                            //   child: ElevatedButton(
                            //     style: ThemeHelper().buttonStyle(),
                            //     child: Padding(
                            //       padding:
                            //           const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            //       child: Text(
                            //         "Send".toUpperCase(),
                            //         style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //     onPressed: () {
                            //       if (_formKey.currentState!.validate()) {
                            //         Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   ForgotPasswordVerificationPage()),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),

                            SizedBox(height: 30.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remember your password? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
