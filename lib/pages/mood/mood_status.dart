import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';

class MoodStatusPage extends StatelessWidget {
  final String? mood;
  const MoodStatusPage({Key? key, this.mood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorsUtil.greyColor,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              StringsUtil.yourMoodTodayIs,
              style: TextStyle(
                  color: ColorsUtil.amberColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 100),
              child: Text(
                mood!,
                style: const TextStyle(fontSize: 50),
              ),
            ),
            SolidButtonWidget(onPressed: () {}, text: StringsUtil.home)
          ],
        ),
      ),
    );
  }
}
