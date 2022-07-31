import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

class CompetitionPage extends StatefulWidget {
  const CompetitionPage(
      {Key? key,
      required this.competition,
      required this.docRef,
      required this.docId})
      : super(key: key);
  final Competition competition;
  final DocumentReference docRef;
  final String docId;

  @override
  State<CompetitionPage> createState() => _CompetitionPageState();
}

class _CompetitionPageState extends State<CompetitionPage> {
  int lastCount = 0;
  bool isTouching = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.competition.name,
      )),
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Competitions')
                .doc(widget.docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Competition compt = Competition.fromMap(snapshot.data!.data()!);
                if (isTouching && lastCount >= 2 && compt.count == 1) {
                  FirebaseUtils.addWinner();
                  return Material(
                    child: SizedBox(
                        height: 300,
                        width: size.width * 0.8,
                        child: const Text(
                            'Congratulations, You Have Won the Competition, Amount will be transfered in your wallet within 2-3 days')),
                  );
                } else {
                  lastCount = compt.count;
                  return Column(
                    children: [
                      Text(
                          'Competition Starts At: ${DateTime.fromMillisecondsSinceEpoch(compt.startDateTime).toString().substring(0, 16)}'),
                      Text(
                        'Total Count: ${compt.count}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onLongPressStart: (details) {
                          isTouching = true;
                          //if (details.sourceTimeStamp!.inSeconds > 2) {
                          print('Last Count is $lastCount');
                          lastCount = compt.count;
                          Competition comp = Competition(
                              count: compt.count + 1,
                              startDateTime: widget.competition.startDateTime,
                              name: widget.competition.name,
                              winnerWallet: widget.competition.winnerWallet);
                          widget.docRef.update(comp.toMap());
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Less than 2')));
                          // }
                        },
                        onLongPressEnd: (details) {
                          isTouching = false;
                          //if (details. != null) {
                          //print('true velocity 2 sec');
                          Competition comp = Competition(
                              count: compt.count - 1,
                              startDateTime: widget.competition.startDateTime,
                              name: widget.competition.name,
                              winnerWallet: widget.competition.winnerWallet);
                          widget.docRef.update(comp.toMap());
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Less than 2')));
                          // }
                        },
                        child: Container(
                          height: size.height * 0.7,
                          width: size.width * 0.9,
                          color: Colors.green,
                        ),
                      )
                    ],
                  );
                }
              } else {
                return const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}
