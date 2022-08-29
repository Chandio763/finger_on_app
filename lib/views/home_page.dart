// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/image_picker_dialog.dart';
import 'package:finger_on_app/views/add_competition.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:finger_on_app/views/wating.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.isAdmin}) : super(key: key);
  final bool isAdmin;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isAdmin ? true : false,
        title: const Text('Available Competitions'),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isAdmin) {
                  //ADD Competition Screen

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddCompetition()));
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                }
              },
              icon: Icon(!widget.isAdmin ? Icons.logout_rounded : Icons.add))
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        //color: Colors.green,
        child: Column(
          children: [
            // user != null
            //     ? user!.isApproved
            //         ? const SizedBox()
            //         : const Padding(
            //             padding:
            //                 EdgeInsets.only(top: 12.0, left: 12, right: 12),
            //             child: Text(
            //               'Your Account is Pending, Pay us at "TP1d5wzkY18Y9jVnmtDanPMcmHAx4WAFXK" and upload screenshot below to participate',
            //               style: TextStyle(fontSize: 12, color: Colors.red),
            //             ),
            //           )
            //     : const SizedBox(),
            SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseUtils.getCompetitions,
                builder: (ctx, snapshot) {
                  print('builder iss ');
                  if (snapshot.hasData) {
                    print('snapshot Data iss ');
                    var competitionsList = snapshot.data!.docs.map((e) {
                      print('Data iss ${e.data()}');
                      return Competition.fromMap(e.data());
                    }).toList();
                    var listOfDocLocation = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: competitionsList.length,
                        itemBuilder: (context, index) {
                          var startTime = DateTime.fromMillisecondsSinceEpoch(
                              competitionsList[index].startDateTime);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                tileColor: Colors.green.shade100,
                                iconColor: Colors.green,
                                title: Text(competitionsList[index].name),
                                subtitle: Text(
                                    'Start at: ${startTime.toString().substring(0, 16)}'),
                                trailing: IconButton(
                                  onPressed: () {
                                    var remainingTime = competitionsList[index]
                                            .startDateTime -
                                        DateTime.now().millisecondsSinceEpoch;
                                    print(
                                        'remaining time in miliseconds is $remainingTime');
                                    print(
                                        'competetion time is  ${competitionsList[index].startDateTime}');
                                    if (!widget.isAdmin) {
                                      if (user != null && user!.isApproved) {
                                        //1 minute is equal to 6000
                                        if (60000 > remainingTime &&
                                            remainingTime > 0) {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                CompetitionPage(
                                                    competition:
                                                        competitionsList[index],
                                                    docRef:
                                                        listOfDocLocation[index]
                                                            .reference,
                                                    docId:
                                                        listOfDocLocation[index]
                                                            .id),
                                          ));
                                        } else {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              // return Waiting(remainingTime: competitionsList[index].startDateTime,);
                                              return WaitingTime(
                                                endTime: competitionsList[index]
                                                    .startDateTime,
                                              );
                                            },
                                          ));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Your Account is UnApproved, Please pay, Send SS and get Approved')));
                                      }
                                    } else {
                                      //Delete Competition Item
                                      listOfDocLocation[index]
                                          .reference
                                          .delete();
                                    }
                                  },
                                  icon: Icon(widget.isAdmin
                                      ? Icons.delete
                                      : Icons.arrow_forward_ios_outlined),
                                )),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
