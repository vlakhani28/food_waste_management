import 'package:flutter/material.dart';
import 'package:food_waste_management/screens/OnBoardingScreen.dart';
import 'package:food_waste_management/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 300.0,
                width: 300.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   initialize();
  }

  void initialize() async {
    var d = Duration(seconds: 3);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => OnBoardingScreen(),
          ),
          (route) => false);
    });
  }
}
