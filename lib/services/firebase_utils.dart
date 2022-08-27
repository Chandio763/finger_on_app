import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/model/winner.dart';

class FirebaseUtils {
  static Stream<QuerySnapshot<Map<String, dynamic>>> get getCompetitions =>
      FirebaseFirestore.instance.collection('Competitions')
      .where('startDateTime',isGreaterThan: DateTime.now().millisecondsSinceEpoch)
      .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> get getWinner =>
      FirebaseFirestore.instance.collection(winnerCollection).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers(bool isApproved) {
    return FirebaseFirestore.instance
        .collection(userCollection)
        .where('isApproved', isEqualTo: isApproved)
        .snapshots();
  }

  static void updateUser(
      {required AppUser user, required DocumentReference docRef}) {
    docRef.update(user.toMap()).then((docRef) {
      print('-----------------------------------------update successfully');
    });
  }

  static void updateCompetition(
      {required Competition competition, required DocumentReference docRef}) {
    docRef.update(competition.toMap()).then((docRef) {
      print('-----------------------------------------update successfully');
    });
  }

  static void addUser(AppUser user) {
    FirebaseFirestore.instance.collection(userCollection).add(user.toMap());
  }

  static void addCompetition(Competition competition) {
    FirebaseFirestore.instance
        .collection(competitionCollection)
        .add(competition.toMap());
  }

  static void addWinner() {
    FirebaseFirestore.instance.collection(winnerCollection).add(Winner(
            email: user!.email,
            walletAddress: user!.walletAddress,
            isPaid: false)
        .toMap());
  }

  static Future<Map<String, dynamic>> validateUser(
      {required String email, required String password}) async {
    bool isValid = false;
    bool isApproved = false;
    // var userRef;
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
            user = AppUser.fromMap(item.data());
            userRef = item.reference;
            if (item.data()['isApproved'] == true) {
              isApproved = true;
            }
            //userRef = item.reference;
            continue;
          }
        }
      });
    } catch (e) {
      isValid = false;
    }
    return {'isValid': isValid, 'isApproved': isApproved};
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
