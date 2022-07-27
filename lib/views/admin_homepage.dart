import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

class AdminsHomePage extends StatefulWidget {
  const AdminsHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminsHomePage> createState() => _AdminsHomePageState();
}

class _AdminsHomePageState extends State<AdminsHomePage> {
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
            stream: FirebaseUtils.getUsers,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                var competitionsList = snapshot.data!.docs.map((e) {
                  return AppUser.fromMap(e.data());
                }).toList();
                var listOfDocLocation = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: competitionsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(competitionsList[index].email),
                        subtitle: Text(competitionsList[index].walletAddress),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.check)));
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
