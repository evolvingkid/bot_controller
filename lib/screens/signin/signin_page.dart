import 'package:botcontroller/core/firebase_mob_auth.dart';
import 'package:botcontroller/helpers/custom_route_page.dart';
import 'package:botcontroller/provider/firebase_auth.dart';
import 'package:botcontroller/screens/opt/opt_page.dart';
import 'package:botcontroller/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextStyle headingTxt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff5933AA));
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _mobNumber;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isVerified;

  otpNeeded() {
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamed(OTPPage.routeName,
        arguments: {'type': 'signIn', 'mobileNumber': _mobNumber});
  }

  Future<void> accVerification(bool _val) async {
    if (_val) {
      _isVerified = await Provider.of<FirebaseAuth>(context, listen: false)
          .accVerification(_mobNumber);

      if (!_isVerified) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Please ensure you have an account or it is verified'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error Occured please check you mobile number'),
        duration: Duration(seconds: 3),
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> signInOnSubmit() async {
    setState(() {
      _isLoading = true;
    });

    await FirebaseMobAuth.loginUser(_mobNumber, context, (_val) {
      accVerification(_val);
    }, () {
      otpNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: '1',
              child: Container(
                child: SvgPicture.asset('assets/images/login_page_logo.svg'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'TinkerHub Bot',
              style: headingTxt,
            ),
            const SizedBox(height: 30),
            siginForm(screenWidth, context),
            const SizedBox(height: 30),
            Text(
              'or',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
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
          onPressed: () {
            //  Navigator.of(context).pushNamed(SingnUpPage.routName);
            Navigator.of(context).push(CustomRoute(
              builder: (ctx) => SingnUpPage(),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text('Sign up'),
          ),
        ));
  }

  Form siginForm(screenWidth, context) {
    return Form(
        key: _formKey,
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            Container(
              width: screenWidth * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (_val) {
                  if (_val.isEmpty) {
                    return 'Enter your mobile number';
                  }
                  if (_val.length != 10) {
                    return 'Enter correct number';
                  }
                },
                onSaved: (_val) {
                  _mobNumber = '+91$_val';
                },
                decoration: customInputDecoration(),
              ),
            ),
            SizedBox(height: 50),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: screenWidth * 0.8,
                    child: RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          signInOnSubmit();
                        }
                      },
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
