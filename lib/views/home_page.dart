import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finger on App'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        //color: Colors.green,
        child: Center(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseUtils.getCompetitions,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                var competitionsList = snapshot.data!.docs.map((e) {
                  return Competition.fromMap(e.data());
                }).toList();
                var listOfDocLocation = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: competitionsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        //Move To Competition Page
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CompetitionPage(
                              competition: competitionsList[index],
                              docRef: listOfDocLocation[index].reference,
                              docId: listOfDocLocation[index].id),
                        ));
                      },
                      title: Text(competitionsList[index].name),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator(
                  color: Colors.green,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
