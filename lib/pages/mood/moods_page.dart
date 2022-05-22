import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/pages/mood/mood_status.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/data_util.dart';

class MoodsPage extends StatefulWidget {
  final String? id;
  const MoodsPage({Key? key, this.id}) : super(key: key);

  @override
  State<MoodsPage> createState() => _MoodsPageState();
}

class _MoodsPageState extends State<MoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        color: ColorsUtil.blackColor,
        child: Column(
          children: [
            //Heading

            const Center(
              child: Text("👀 Whats Your Mood Today 👀",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
            ),

            // List of emojis
            ListView.builder(
              itemCount: moodsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      DatabaseService().addMood(
                          DatabaseService.currentUser!.uid, moodsList[index]);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              MoodStatusPage(mood: moodsList[index]),
                        ),
                      );
                    },
                    child: Text(
                      moodsList[index],
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
