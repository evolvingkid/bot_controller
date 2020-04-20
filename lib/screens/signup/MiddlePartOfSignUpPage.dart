import 'package:flutter/material.dart';

class MiddlePartOfSignUpPage extends StatelessWidget {
  MiddlePartOfSignUpPage({
    @required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            siginUpTextFeild(screenWidth),
            const SizedBox(height: 20),
            tipMsg(screenWidth),
            const SizedBox(height: 50),
            siginupRaisedBtn(screenWidth, context)
          ],
        ));
  }

  Container siginupRaisedBtn(double screenWidth, BuildContext context) {
    return Container(
      width: screenWidth * 0.7,
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        onPressed: () {},
        textColor: Colors.white,
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text('Proceed'),
        ),
      ),
    );
  }

// * the msg that show below the textfeild
  Container tipMsg(double screenWidth) {
    return Container(
        width: screenWidth * 0.6,
        child: Text(
          'We will send One Time Password through sms',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ));
  }

  Container siginUpTextFeild(double screenWidth) {
    return Container(
        width: screenWidth * 0.7,
        child: TextField(
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'India (+91) '),
        ));
  }
}
