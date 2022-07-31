import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/views/competition_page.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {
  const AppUsers({Key? key, required this.isApproved}) : super(key: key);
  final bool isApproved;

  @override
  State<AppUsers> createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
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
            stream: FirebaseUtils.getUsers(widget.isApproved),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                var usersList = snapshot.data!.docs.map((e) {
                  return AppUser.fromMap(e.data());
                }).toList();
                var listOfDocLocation = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          if (usersList[index].screenShot != null &&
                              usersList[index].screenShot.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text('Uploaded Image'),
                                  ),
                                  body: SizedBox(
                                    height: size.height,
                                    width: size.width,
                                    child: Container(
                                      width: size.width,
                                      //height: ,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: const Color(0xff3BCEAC),
                                          )),
                                      child: Image.network(
                                          usersList[index].screenShot,
                                          errorBuilder:
                                              ((context, error, stackTrace) =>
                                                  Text('Invalid Image'))),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No Image Uploaded')));
                          }
                        },
                        title: Text(usersList[index].email),
                        subtitle: Text(usersList[index].walletAddress),
                        trailing: IconButton(
                            onPressed: () {
                              if (widget.isApproved) {
                                AppUser user = AppUser(
                                    screenShot: usersList[index].screenShot,
                                    email: usersList[index].email,
                                    password: usersList[index].password,
                                    walletAddress:
                                        usersList[index].walletAddress,
                                    isApproved: false);
                                FirebaseUtils.updateUser(
                                    user: user,
                                    docRef: listOfDocLocation[index].reference);
                              } else {
                                AppUser user = AppUser(
                                    email: usersList[index].email,
                                    password: usersList[index].password,
                                    walletAddress:
                                        usersList[index].walletAddress,
                                    screenShot: usersList[index].screenShot,
                                    isApproved: true);
                                FirebaseUtils.updateUser(
                                    user: user,
                                    docRef: listOfDocLocation[index].reference);
                              }
                            },
                            icon: Icon(
                              !widget.isApproved ? Icons.check : Icons.cancel,
                              color: Colors.green,
                            )));
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
