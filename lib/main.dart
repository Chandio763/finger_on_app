import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:finger_on_app/views/login_page.dart';
import 'package:finger_on_app/views/home_page.dart';
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
          primarySwatch: primaryGreen,
          iconTheme: IconThemeData(
            color: primaryGreen,
          )),
      home: const LoginPage(),
    );
  }
}
