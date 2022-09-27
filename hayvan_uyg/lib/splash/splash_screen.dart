import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayvan_uyg/main.dart';
import 'package:hayvan_uyg/pages/MainPage.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var user;

  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Home()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Home()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage("images/logo2.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 750,
                    child: Center(
                      child: Image.asset(
                        'images/logo3.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}