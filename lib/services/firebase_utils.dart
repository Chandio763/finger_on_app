import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/model/user_model.dart';

class FirebaseUtils {
  static Stream<QuerySnapshot<Map<String, dynamic>>> get getCompetitions =>
      FirebaseFirestore.instance.collection('Competitions').snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> get getUsers =>
      FirebaseFirestore.instance.collection(userCollection).snapshots();

  static void updateCompetition(
      {required Competition competition, required DocumentReference docRef}) {
    docRef.update(competition.toMap()).then((docRef) {
      print('-----------------------------------------update successfully');
    });
  }

  static void addUser(AppUser user) {
    FirebaseFirestore.instance.collection(userCollection).add(user.toMap());
  }

  static Future<Map<String, dynamic>> validateUser(
      {required String email, required String password}) async {
    bool isValid = false;
    var userRef;
    try {
      //print('validate Method Called on $phone');
      await FirebaseFirestore.instance
          .collection(userCollection)
          .get()
          .then((value) async {
        QuerySnapshot<Map<String, dynamic>> users = value;
        //print('Method Called on ${value.docs[0].data()}');
        for (var item in users.docs) {
          //print('Data of Item ${item.data()}');
          if (item.data()['email'] == email &&
              item.data()['password'] == password) {
            isValid = true;
            userRef = item.reference;
            continue;
          }
        }
      });
    } catch (e) {
      isValid = false;
    }
    return {'isValid': isValid, 'userRef': userRef ?? ''};
  }

  static Future<Map<String, dynamic>> validateAdmin(
      {required String email, required String password}) async {
    bool isValid = false;
    try {
      //print('validate Method Called on $phone');
      await FirebaseFirestore.instance
          .collection(adminsCollection)
          .get()
          .then((value) async {
        QuerySnapshot<Map<String, dynamic>> users = value;
        //print('Method Called on ${value.docs[0].data()}');
        for (var item in users.docs) {
          //print('Data of Item ${item.data()}');
          if (item.data()['email'] == email &&
              item.data()['password'] == password) {
            isValid = true;
            //userRef = item.reference;
            continue;
          }
        }
      });
    } catch (e) {
      isValid = false;
    }
    return {'isValid': isValid};
  }
}
