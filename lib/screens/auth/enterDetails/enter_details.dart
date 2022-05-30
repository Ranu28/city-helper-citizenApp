import 'package:flutter/material.dart';

class EnterYourDetails extends StatefulWidget {
  const EnterYourDetails({Key? key}) : super(key: key);

  @override
  State<EnterYourDetails> createState() => _EnterYourDetailsState();
}

class _EnterYourDetailsState extends State<EnterYourDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Enter Details'),
    );
  }
}
