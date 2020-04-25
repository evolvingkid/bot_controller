import 'package:botcontroller/provider/firebase_auth.dart';
import 'package:botcontroller/screens/opt/opt_page.dart';
import 'package:botcontroller/screens/signin/signin_page.dart';
import 'package:botcontroller/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/application_form/acc_application_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FirebaseAuth(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue, accentColor: Color(0xff5933AA)),
        routes: {
          SingnUpPage.routName: (ctx) => SingnUpPage(),
          OTPPage.routeName: (ctx) => OTPPage(),
          SignInAplicationForm.routeName: (ctx) => SignInAplicationForm()
        },
        home: SigninPage(),
      ),
    );
  }
}
