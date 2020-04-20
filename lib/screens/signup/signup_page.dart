import 'package:botcontroller/screens/signup/MiddlePartOfSignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingnUpPage extends StatelessWidget {

static const routName = './siginUpPage';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topBar(screenHeight, screenWidth),
            MiddlePartOfSignUpPage(screenHeight: screenHeight)
          ],
        ),
      ),
    );
  }

  Container topBar(double screenHeight, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff5933AA),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 7),
              blurRadius: 6)
        ],
      ),
      height: screenHeight * 0.4,
      width: screenWidth,
      child: Center(
        child: Stack(
          children: <Widget>[topBarCenterComponet(), topBarBottomComponet()],
        ),
      ),
    );
  }

  Align topBarBottomComponet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Enter your mobile number below',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Align topBarCenterComponet() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: SvgPicture.asset('assets/images/singup_page_logo.svg')),
          const SizedBox(height: 10),
          Text(
            'Welcome to Bot',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
