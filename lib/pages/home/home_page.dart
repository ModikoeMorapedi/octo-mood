import 'package:flutter/material.dart';
import 'package:octo_mood/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:octo_mood/utils/colors_util.dart';
import 'package:octo_mood/utils/strings_util.dart';

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
        body: Container(
            color: ColorsUtil.amberColor,
            padding: const EdgeInsets.only(top: 47, left: 35, right: 35),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Sorting Button, sort by Date in ascending and descending order
                  IconButton(
                    onPressed: (() {
                      setState(() {
                        if (isDescending == false) {
                          isDescending = true;
                        } else {
                          isDescending = false;
                        }
                      });
                    }),
                    icon: const Icon(Icons.arrow_upward_outlined),
                    color: ColorsUtil.greenColor,
                  ),
                  //Search bar for searching users by name
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 200,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorsUtil.blackColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsUtil.blackColor, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorsUtil.blackColor, width: 2)),
                      ),
                    ),
                  ),

                  //Logout button
                  IconButton(
                    onPressed: () {
                      DatabaseService().signOut();
                      Navigator.pushNamed(context, StringsUtil.loginPage);
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: ColorsUtil.greenColor,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: DatabaseService().getData(isDescending),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) => snapshot.hasData ==
                                    true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 3, top: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]
                                                        .get('nickName')
                                                        .toString()
                                                        .toUpperCase() +
                                                    " is in a " +
                                                    snapshot.data!.docs[index]
                                                        .get('mood') +
                                                    " M👀d",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              IconButton(
                                                  onPressed: (() {
                                                    DatabaseService()
                                                        .deleteProfile(snapshot
                                                            .data!.docs[index]
                                                            .get('id'));
                                                  }),
                                                  icon: Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      color:
                                                          ColorsUtil.redColor))
                                            ],
                                          )),
                                      // Text(
                                      //   snapshot.data!.docs[index].get('mood') +
                                      //       " mood",
                                      //   style: TextStyle(fontSize: 30),
                                      // ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 2,
                                        color: ColorsUtil.greyColor,
                                        margin: const EdgeInsets.only(top: 4),
                                      )
                                    ],
                                  )
                                : Container(
                                    color: ColorsUtil.greenColor,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 25,
                                    ),
                                  ));
                      })),
            ])));
  }
}
