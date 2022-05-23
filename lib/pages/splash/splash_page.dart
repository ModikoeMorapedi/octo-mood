import 'dart:async';

import 'package:flutter/material.dart';
import 'package:octo_mood/pages/auth/login_page.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/images_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:google_fonts/google_fonts.dart';

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
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.greyColor,
      body: Container(
          alignment: Alignment.center,
          color: ColorsUtil.greenColor,
          child: Column(
            children: [
              Container(
                  color: ColorsUtil.whiteColor,
                  padding: EdgeInsets.only(top: 80, bottom: 50),
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(ImagesUtil.octoImage)),
              Container(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Text(
                    StringsUtil.octoMoodApp,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ))
            ],
          )),
    );
  }
}
