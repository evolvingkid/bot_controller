import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SiginUpPage extends StatelessWidget {
  TextStyle headingTxt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff5933AA));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SvgPicture.asset('assets/images/login_page_logo.svg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'TinkerHub Bot',
              style: headingTxt,
            ),
            SizedBox(height: 30),
            siginForm(screenWidth, context),
            SizedBox(height: 30),
            Text(
              'or',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            siginUpBtn(screenWidth, context)
          ],
        ),
      ),
    );
  }

  Container siginUpBtn(double screenWidth, context) {
    return Container(
        width: screenWidth * 0.5,
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
          textColor: Theme.of(context).accentColor,
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text('Sign up'),
          ),
        ));
  }

  Form siginForm(screenWidth, context) {
    return Form(
        child: Center(
            child: SingleChildScrollView(
                child: Column(
      children: <Widget>[
        Container(
          width: screenWidth * 0.8,
          child: TextFormField(
            decoration: customInputDecoration(),
          ),
        ),
        SizedBox(height: 50),
        Container(
          width: screenWidth * 0.8,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text('Login'),
            ),
          ),
        )
      ],
    ))));
  }

  InputDecoration customInputDecoration() {
    return InputDecoration(
        suffixIcon: Icon(Icons.info),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(0xff5933AA), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        hintText: 'Phone no');
  }
}
