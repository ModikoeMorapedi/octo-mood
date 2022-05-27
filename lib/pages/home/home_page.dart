import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:octo_mood/main.dart';
import 'package:octo_mood/pages/mood/moods_page.dart';
import 'package:octo_mood/pages/notification/push_notification_page.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/images_util.dart';
import 'package:octo_mood/utils/strings_util.dart';
import 'package:octo_mood/widgets/loading_widget.dart';
import 'package:octo_mood/widgets/textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.isEdited, this.userNewMood}) : super(key: key);
  bool? isEdited = false;
  String? userNewMood = "";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDescending = false;
  late RemoteNotification notification;
  static String? _userToken;
  static String? _userOldMood;
  static String? _selectedUser;

  void getToken(String token, String mood, String selectdUser) {
    _userToken = token;
    _userOldMood = mood;
    _selectedUser = selectdUser;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.isEdited != null
          ? DatabaseService().sendPushMessage(
              title: widget.userNewMood!,
              body: _userOldMood!,
              token: _userToken!,
              user: _selectedUser!)
          : null;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notification = message.notification!;
      AndroidNotification? android = message.notification?.android;

      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

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
                            margin: const EdgeInsets.only(bottom: 2, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    width: 35,
                                    height: 60,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: IconButton(
                                            onPressed: (() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      MoodsPage(
                                                        userMoodsList: [],
                                                        id: snapshot
                                                            .data!.docs[index]
                                                            .get(
                                                                StringsUtil.id),
                                                      )),
                                                ),
                                              );

                                              getToken(
                                                  snapshot.data!.docs[index]
                                                      .get("deviceToken"),
                                                  snapshot.data!.docs[index]
                                                      .get("mood"),
                                                  snapshot.data!.docs[index]
                                                      .get("nickName"));
                                              // DatabaseService().sendPushMessage(
                                              //     "Body",
                                              //     "My name",
                                              //     snapshot.data!.docs[index]
                                              //         .get("deviceToken"));
                                            }),
                                            icon: const Icon(
                                              Typicons.edit,
                                              color: ColorsUtil.greenColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: (() {
                                              DatabaseService().deleteProfile(
                                                  snapshot.data!.docs[index]
                                                      .get(StringsUtil.id));
                                            }),
                                            icon: const Icon(
                                              Icons.delete_forever_outlined,
                                              color: ColorsUtil.redColor,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
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
                    : LoadingWidget());
          }),
    );
  }
}
