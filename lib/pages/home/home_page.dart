import 'package:flutter/material.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/images_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDescending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.blackColor,
      body: Container(
        color: ColorsUtil.blackColor,
        padding: const EdgeInsets.only(top: 47, left: 35, right: 35),
        child: Column(
          children: [
            //Header
            headerWidget(context),
            const SizedBox(
              height: 30,
            ),
            //Body
            bodyWidget(context)
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Sorting Button, sort by Date in ascending and descending order
        InkWell(
          onTap: (() {
            setState(() {
              if (isDescending == false) {
                isDescending = true;
              } else {
                isDescending = false;
              }
            });
          }),
          child: Column(
            children: [
              // Image.asset(
              //   ImagesUtil.sortImage,
              //   color: ColorsUtil.greenColor,
              //   height: 30,
              //   width: 30,
              // ),
              const Icon(
                Icons.sort_rounded,
                color: ColorsUtil.greenColor,
                size: 30,
              ),
              Text(
                StringsUtil.sort,
                style: GoogleFonts.grapeNuts(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: ColorsUtil.greenColor),
                ),
              ),
            ],
          ),
        ),
        //Search bar for searching users by name
        Container(
          padding: const EdgeInsets.only(top: 20),
          width: 200,
          child: const TextFormFieldWidget(
            color: ColorsUtil.greenColor,
            hintColor: ColorsUtil.whiteColor,
            hintText: StringsUtil.searchUsersByName,
          ),
        ),

        //Logout button
        Column(
          children: [
            IconButton(
              onPressed: () {
                DatabaseService().signOut();
                Navigator.pushNamed(context, StringsUtil.loginPage);
              },
              icon: const Icon(Icons.logout_outlined),
              color: ColorsUtil.greenColor,
              iconSize: 30,
            ),
            Text(
              StringsUtil.logout,
              style: GoogleFonts.grapeNuts(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ColorsUtil.greenColor),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: DatabaseService().getData(isDescending),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => snapshot.hasData == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 3, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: snapshot.data!.docs[index]
                                        .get(StringsUtil.nickName)
                                        .toString()
                                        .toUpperCase(),
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: ColorsUtil.greyColor),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: StringsUtil.isFeeling,
                                        style: GoogleFonts.grapeNuts(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: ColorsUtil.greyColor),
                                        ),
                                      ),
                                      TextSpan(
                                          text: snapshot.data!.docs[index]
                                              .get(StringsUtil.mood)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                child: IconButton(
                                  onPressed: (() {
                                    DatabaseService().deleteProfile(snapshot
                                        .data!.docs[index]
                                        .get(StringsUtil.id));
                                  }),
                                  icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: ColorsUtil.redColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: ColorsUtil.greyColor,
                          margin: const EdgeInsets.only(top: 4),
                        ),
                      ],
                    )
                  : Container(
                      color: ColorsUtil.greenColor,
                      alignment: Alignment.center,
                      child: const Text(StringsUtil.noDataAvailable),
                    ),
            );
          }),
    );
  }
}
