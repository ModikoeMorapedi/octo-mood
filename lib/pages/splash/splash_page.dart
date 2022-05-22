import 'dart:async';

import 'package:flutter/material.dart';
import 'package:octo_mood/pages/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return  Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  initScreen(BuildContext context) {
    
    return const Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text("Welcome to octo moood app"),
        // child: Lottie.asset(
        //   'assets/Welcome/Splash Screen.json',
        // ),
      ),
    );
  }
}