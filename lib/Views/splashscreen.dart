import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato_app/Views/homepage.dart';
//import 'package:pizzato_app/Views/selectionpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    Timer(
      Duration(
        seconds: 3
      ),
      () => Navigator.pushReplacement(context, PageTransition(
        child: HomePage(), 
        type: PageTransitionType.leftToRightWithFade),
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 400,
              child: Lottie.asset(
                'animations/22795-pizza-slice.json'
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Piz', style: TextStyle(
                  fontSize: 56, fontWeight: FontWeight.bold, color: Colors.black
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'z', style: TextStyle(
                  fontSize: 56, fontWeight: FontWeight.bold, color: Colors.red
                ),
                 ),
                 TextSpan(
                   text: 'ato', style: TextStyle(
                  fontSize: 56, fontWeight: FontWeight.bold, color: Colors.black
                ),
                 ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}