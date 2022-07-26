import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/model/competiton.dart';
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
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Competitions')
                    .doc(widget.docId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Competition compt =
                        Competition.fromMap(snapshot.data!.data()!);
                    return Column(
                      children: [
                        Text('Total Count: ${compt.count}'),
                        GestureDetector(
                          onLongPressStart: (details) {
                            //if (details.sourceTimeStamp!.inSeconds > 2) {
                            print('true touched 2 sec');
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
                            //if (details. != null) {
                            print('true velocity 2 sec');
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
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.green,
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
