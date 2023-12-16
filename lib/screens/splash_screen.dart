import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teleplay/screens/auth/screens/login_screen.dart';
import 'package:teleplay/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    var duration = const Duration(seconds: 1, milliseconds: 300);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("id");
    if (email == null) {
      return Timer(duration, route1);
    } else {
      return Timer(duration, route2);
    }
  }

  route1() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  route2() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/teleplay_logo.png',
              height: 300,
            ),
            const SizedBox(height: 50),
            const CupertinoActivityIndicator(
              radius: 16,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
