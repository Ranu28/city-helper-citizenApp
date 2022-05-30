import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/backend/provinces_and_cities/call_api.dart';
import 'package:flutter_login_ui/models/cities.dart';
import 'package:flutter_login_ui/models/districts.dart';
import 'package:flutter_login_ui/models/listOfDistricts.dart';
import 'package:flutter_login_ui/models/provinces.dart';
import 'package:flutter_login_ui/widget/ThemeLogin/theme_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int currentStep = 0;
  String? pss;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String? selectedDistrict;

  //controllers
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController nicController = new TextEditingController();

  TextEditingController streetNoController = new TextEditingController();
  TextEditingController streetNameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController postalCodeController = new TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final items = ['item1', 'item2', "item3"];
  String? value;
  String dropdownValue = 'Select your province';
  late List<Districts> districtsPovince;
  bool isEmptyDistrict = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Details"),
        backgroundColor: HexColor('#75b9e6'),
      ),
      body: Container(
        child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: HexColor('#75b9e6'),
          )),
          child: Stepper(
              currentStep: currentStep,
              type: StepperType.horizontal,
              steps: getSteps(),
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  print("complete");
                }
                setState(() {
                  currentStep += 1;
                });
              },
              onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
              onStepCancel: () {
                currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      });
              },
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: controls.onStepContinue,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: const Text('NEXT'),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('#75b9e6'),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: controls.onStepCancel,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: const Text('PREVIOUS'),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('#75b9e6'),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep == 0,
          title: Text("Personal Data"),
          content: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: firstNameController,
                  obscureText: false,
                  decoration: ThemeHelper().textInputDecoration(
                      "First Name", "Enter your First Name"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter First Name";
                    }
                    pss = val.toString();
                    return null;
                  },
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                  controller: lastNameController,
                  obscureText: false,
                  decoration: ThemeHelper()
                      .textInputDecoration("Last Name", "Enter your Last Name"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter your Last Name";
                    }
                    pss = val.toString();
                    return null;
                  },
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: mobileNumberController,
                  obscureText: false,
                  decoration: ThemeHelper().textInputDecoration(
                      "Mobile Number", "Enter your Mobile Number"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter You Mobile Number";
                    }
                    pss = val.toString();
                    return null;
                  },
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                  maxLength: 12,
                  controller: nicController,
                  obscureText: false,
                  decoration: ThemeHelper()
                      .textInputDecoration("NIC", "Enter your NIC"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter NIC";
                    }
                    pss = val.toString();
                    return null;
                  },
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
            ],
          ),
        ),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep == 1,
            title: Text("Address"),
            content: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: streetNoController,
                    obscureText: false,
                    decoration: ThemeHelper().textInputDecoration(
                        "Street No", "Enter your Street No"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Street Number";
                      }
                      pss = val.toString();
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: streetNameController,
                    obscureText: false,
                    decoration: ThemeHelper().textInputDecoration(
                        "Street Name", "Enter your Street Name"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Street Name";
                      }
                      pss = val.toString();
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: cityController,
                    obscureText: false,
                    decoration: ThemeHelper()
                        .textInputDecoration("City", "Enter your City"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter City";
                      }
                      pss = val.toString();
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: districtController,
                    obscureText: false,
                    decoration: ThemeHelper()
                        .textInputDecoration("District", "Enter your District"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter District";
                      }
                      pss = val.toString();
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: postalCodeController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: ThemeHelper().textInputDecoration(
                        "Postal Code", "Enter your Postal Code"),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Postal Code";
                      }
                      pss = val.toString();
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ],
            )),
        Step(
          state: currentStep == 2 ? StepState.editing : StepState.indexed,
          isActive: currentStep == 2,
          title: Text("Confirm"),
          content: Container(),
        ),
      ];
}
