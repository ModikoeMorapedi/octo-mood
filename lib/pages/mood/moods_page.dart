import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octo_mood/pages/home/home_page.dart';
import 'package:octo_mood/pages/mood/mood_status.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/data_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodsPage extends StatefulWidget {
  String? id = "";
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
      backgroundColor: ColorsUtil.blackColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        color: ColorsUtil.blackColor,
        child: Column(
          children: [
            //Header
            headerWidget(context),
            //Body
            bodyWidget(context),
            //Footer
            footerWidget(context),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
          onPressed: (() {
            Navigator.pushNamed(context, StringsUtil.settingsPage);
          }),
          icon: const Icon(
            Icons.settings,
            color: ColorsUtil.whiteColor,
            size: 35,
          )),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            widget.id == null ? StringsUtil.howHowAre : "You are changing",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: ColorsUtil.whiteColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Icon(
                Icons.calendar_today,
                color: ColorsUtil.greenColor,
                size: 17,
              ),
            ),
            Column(children: [
              Text(
                StringsUtil.today + DateTime.now().toString().substring(0, 10),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: ColorsUtil.greenColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 130,
                height: 1,
                color: ColorsUtil.greenColor,
              )
            ]),
          ]),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget footerWidget(BuildContext context) {
    return Column(
      children: [
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
                        widget.id == null
                            ? DatabaseService.currentUser!.uid
                            : widget.id!,
                        widget.userMoodsList!.isEmpty
                            ? moodsList[index]
                            : widget.userMoodsList![index]);
                    if (widget.id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => HomePage(
                              isEdited: true,
                              userNewMood: widget.userMoodsList!.isEmpty
                                  ? moodsList[index]
                                  : widget.userMoodsList![index])),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, StringsUtil.homePage);
                    }
                  },
                  child: Row(children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorsUtil.greenColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.userMoodsList!.isEmpty
                          ? moodsList[index]
                          : widget.userMoodsList![index],
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.arrow_back,
                      color: ColorsUtil.greenColor,
                    ),
                  ])),
              Container(
                color: ColorsUtil.greenColor,
                height: 0.3,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 15, bottom: 10),
              )
            ],
          ),
        ),
      ],
    );
  }
}
