// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/image_picker_dialog.dart';
import 'package:finger_on_app/model/winner.dart';
import 'package:finger_on_app/views/add_competition.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class WinnerList extends StatefulWidget {
  const WinnerList({Key? key, required this.isAdmin}) : super(key: key);
  final bool isAdmin;

  @override
  State<WinnerList> createState() => _WinnerListState();
}

class _WinnerListState extends State<WinnerList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isAdmin ? true : false,
        title: const Text('Winners'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         if (widget.isAdmin) {
        //           //ADD Competition Screen
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => const AddCompetition()));
        //         } else {
        //           Navigator.of(context).pushAndRemoveUntil(
        //               MaterialPageRoute(
        //                   builder: (context) => const LoginPage()),
        //               (route) => false);
        //         }
        //       },
        //       icon: Icon(!widget.isAdmin ? Icons.logout_rounded : Icons.add))
        // ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        //color: Colors.green,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseUtils.getWinner,
          builder: (ctx, snapshot) {
            print('builder iss ');
            if (snapshot.hasData) {
              print('snapshot Data iss ');
              var competitionsList = snapshot.data!.docs.map((e) {
                print('Data iss ${e.data()}');
                return Winner.fromMap(e.data());
              }).toList();
              var listOfDocLocation = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: competitionsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.green.shade100,
                        iconColor: Colors.green,
                        title: Text(competitionsList[index].email),
                        subtitle: Text(
                            'Wallet: ${competitionsList[index].walletAddress}'),
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     if (!widget.isAdmin) {
                        //       if (user != null && user!.isApproved) {
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => CompetitionPage(
                        //               competition: competitionsList[index],
                        //               docRef:
                        //                   listOfDocLocation[index].reference,
                        //               docId: listOfDocLocation[index].id),
                        //         ));
                        //       } else {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //             const SnackBar(
                        //                 content: Text(
                        //                     'Your Account is UnApproved, Please pay, Send SS and get Approved')));
                        //       }
                        //     } else {
                        //       //Delete Competition Item
                        //       listOfDocLocation[index].reference.delete();
                        //     }
                        //   },
                        //   icon: Icon(widget.isAdmin
                        //       ? Icons.delete
                        //       : Icons.arrow_forward_ios_outlined),
                      ),
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
    );
  }
}
