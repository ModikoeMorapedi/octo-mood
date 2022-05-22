import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/pages/mood/mood_status.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/data_util.dart';
import 'package:octo_mood/utils/strings_util.dart';

class MoodsPage extends StatefulWidget {
  final String? id;
  List<String>? userMoodsList = [];
  MoodsPage({Key? key, this.id, this.userMoodsList}) : super(key: key);

  @override
  State<MoodsPage> createState() => _MoodsPageState();
}

class _MoodsPageState extends State<MoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        color: ColorsUtil.blackColor,
        child: Column(
          children: [
            //Heading
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, StringsUtil.settingsPage);
                  }),
                  icon: const Icon(Icons.settings)),
            ),
            const Center(
              child: Text("👀 Whats Your Mood Today 👀",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
            ),

            // List of emojis
            ListView.builder(
              itemCount: widget.userMoodsList!.isEmpty
                  ? moodsList.length
                  : widget.userMoodsList!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      DatabaseService().addMood(
                          DatabaseService.currentUser!.uid,
                          widget.userMoodsList!.isEmpty
                              ? moodsList[index]
                              : widget.userMoodsList![index]);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MoodStatusPage(
                              mood: widget.userMoodsList!.isEmpty
                                  ? moodsList[index]
                                  : widget.userMoodsList![index]),
                        ),
                      );
                    },
                    child: Text(
                      widget.userMoodsList!.isEmpty
                          ? moodsList[index]
                          : widget.userMoodsList![index],
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    color: ColorsUtil.greenColor,
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
