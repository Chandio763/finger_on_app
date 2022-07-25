import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/competiton.dart';

class FirebaseUtils {
  static Stream<QuerySnapshot<Map<String, dynamic>>> get getLocations =>
      FirebaseFirestore.instance.collection('Competitions').snapshots();

  static void updateUser(
      {required Competition competition, required DocumentReference docRef}) {
    docRef.update(competition.toMap()).then((docRef) {
      print('-----------------------------------------update successfully');
    });
  }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> get getUsers =>
  //     FirebaseFirestore.instance.collection('usersProduction').snapshots();

  // static Stream<QuerySnapshot<Map<String, dynamic>>> get getAdmins =>
  //     FirebaseFirestore.instance.collection('admins').snapshots();

  // static Stream<QuerySnapshot<Map<String, dynamic>>> get getScanners =>
  //     FirebaseFirestore.instance.collection('scannersProduction').snapshots();
}
