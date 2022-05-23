import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/pages/mood/moods_page.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/widgets/button_widget.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> usersMoodsList = [];
  final TextEditingController _emojiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.greyColor,
      body: Container(
        padding: const EdgeInsets.all(40),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const Text("Make Your List Of Moods"),
            Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: 200,
                height: 100,
                child: Row(children: [
                  Container(
                    height: 50,
                    width: 100,
                    child: TextFormField(
                      controller: _emojiController,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsUtil.amberColor, width: 4)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsUtil.amberColor, width: 4)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          usersMoodsList.add(_emojiController.text);
                        });
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        color: ColorsUtil.greenColor,
                        size: 40,
                      ))
                ])),
            SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: usersMoodsList.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            Text(
                              usersMoodsList.isEmpty
                                  ? ""
                                  : usersMoodsList[index],
                              style: const TextStyle(fontSize: 30),
                            ),
                            Container(
                              color: ColorsUtil.greenColor,
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                            )
                          ],
                        ))),
            const SizedBox(
              height: 50,
            ),
            usersMoodsList.isEmpty
                ? Container()
                : SolidButtonWidget(
                    text: "Add to List",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  MoodsPage(userMoodsList: usersMoodsList)));
                    },
                  )
          ],
        ),
      ),
    );
  }
}
