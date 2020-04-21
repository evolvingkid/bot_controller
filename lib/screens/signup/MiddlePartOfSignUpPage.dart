import 'package:flutter/material.dart';
import '../../core/firebase_mob_auth.dart';

class MiddlePartOfSignUpPage extends StatefulWidget {
  MiddlePartOfSignUpPage(
      {@required this.screenHeight, @required this.screenWidth, this.route});

  final double screenHeight;
  final double screenWidth;
  final Route<dynamic> Function() route;

  @override
  _MiddlePartOfSignUpPageState createState() => _MiddlePartOfSignUpPageState();
}

class _MiddlePartOfSignUpPageState extends State<MiddlePartOfSignUpPage> {
  double textFeildPostion = 1;
  double textFeildOpacity = 0.0;
  double animatedBtnOpacity = 0.0;
  String _mobNumber;

  Future animationFunction() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        textFeildPostion = 20;
        textFeildOpacity = 1.0;
        animatedBtnOpacity = 1.0;
      });
    });
  }

  optPageRedirect() {
    Navigator.of(context).push(widget.route());
  }

 void submitMobNumber() async {
    _mobNumber = '+91$_mobNumber';
    var _fetchData =
        await FirebaseMobAuth.loginUser(_mobNumber, context, () {}, () {
      optPageRedirect();
    });

    print(_fetchData.toString());
  }

  @override
  void didChangeDependencies() {
    animationFunction();
    super.didChangeDependencies();
  }

// *build
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: widget.screenHeight * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: screenWidth * 0.7,
              child: Stack(
                children: <Widget>[
                  siginUpTextFeild(screenWidth),
                ],
              ),
            ),
            const SizedBox(height: 20),
            tipMsg(screenWidth),
            const SizedBox(height: 50),
            siginupRaisedBtn(screenWidth, context)
          ],
        ));
  }

  AnimatedOpacity siginupRaisedBtn(double screenWidth, BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: animatedBtnOpacity,
      child: Container(
        width: screenWidth * 0.7,
        child: RaisedButton(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          onPressed: () {
            submitMobNumber();
          },
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text('Proceed'),
          ),
        ),
      ),
    );
  }

  Container tipMsg(double screenWidth) {
    return Container(
        width: screenWidth * 0.6,
        child: Text(
          'We will send One Time Password through sms',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ));
  }

  AnimatedPositioned siginUpTextFeild(double screenWidth) {
    return AnimatedPositioned(
      top: textFeildPostion,
      duration: Duration(milliseconds: 500),
      child: AnimatedOpacity(
        opacity: textFeildOpacity,
        duration: Duration(milliseconds: 500),
        child: Container(
            width: screenWidth * 0.7,
            child: TextField(
              onChanged: (val) {
                _mobNumber = val;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: 'India (+91) '),
            )),
      ),
    );
  }
}
