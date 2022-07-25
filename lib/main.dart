import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/competiton.dart';
import 'package:finger_on_app/firebase_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

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
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseUtils.getLocations,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    var locationsList = snapshot.data!.docs.map((e) {
                      return Competition.fromMap(e.data());
                    }).toList();
                    var listOfDocLocation = snapshot.data!.docs;
                    return GestureDetector(
                      onPanStart: (DragStartDetails details) {
                        FirebaseUtils.updateUser(
                            competition: Competition(
                                winner: '', count: locationsList[0].count + 1),
                            docRef: listOfDocLocation[0].reference);
                      },
                      onPanEnd: (details) {
                        FirebaseUtils.updateUser(
                            competition: Competition(
                                winner: '', count: locationsList[0].count - 1),
                            docRef: listOfDocLocation[0].reference);
                      },
                      child: Container(
                        height: 500,
                        width: 500,
                        color: Colors.green,
                        child: Text(
                            'You have pushed the Screen ${locationsList[0].count}'),
                      ),
                    );
                  } else {
                    return const Text('No Competition');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
