import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/pages/mood/moods_page.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//Settings pages allows users to add thier own list of moods
class _SettingsPageState extends State<SettingsPage> {
  List<String> usersMoodsList = [];
  final TextEditingController _emojiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtil.blackColor,
      body: Container(
        padding: const EdgeInsets.only(top: 80, left: 35, right: 35),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //Header
            headerWidget(context),
            //Body
            //List of Added moods
            //Visible only when moods are added
            bodyWidget(context),
            const SizedBox(
              height: 50,
            ),
            //Footer
            //Navigate to the Moods page
            //Hidden if no mood is added
            footerWidget(context)
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Column(
      children: [
        //heading
        Text(
          StringsUtil.createMoods,
          style: GoogleFonts.macondo(
            textStyle: const TextStyle(
                color: ColorsUtil.whiteColor,
                fontSize: 43,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 35),
          height: 100,
          child: Row(children: [
            SizedBox(
              height: 50,
              width: 200,
              //Moods Input field
              child: TextFormFieldWidget(
                hintColor: ColorsUtil.whiteColor,
                textEditingController: _emojiController,
                color: ColorsUtil.orangeColor,
                width: 3,
                hintText: StringsUtil.pleaseEnterYourMood,
              ),
            ),
            //Adds moods to usersMoodsList and refreshes the UI
            IconButton(
              onPressed: () {
                setState(() {
                  usersMoodsList.add(_emojiController.text);
                });
              },
              icon: const Icon(
                Icons.add_box_rounded,
                color: ColorsUtil.greenColor,
                size: 40,
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget bodyWidget(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: usersMoodsList.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usersMoodsList.isEmpty ? "" : usersMoodsList[index],
              style: const TextStyle(fontSize: 30),
            ),
            Container(
              color: ColorsUtil.greenColor,
              height: 0.3,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 15, bottom: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget footerWidget(BuildContext context) {
    return usersMoodsList.isEmpty
        ? Container()
        : SolidButtonWidget(
            color: ColorsUtil.greenColor,
            width: MediaQuery.of(context).size.width,
            text: StringsUtil.add,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          MoodsPage(userMoodsList: usersMoodsList)));
            },
          );
  }
}
