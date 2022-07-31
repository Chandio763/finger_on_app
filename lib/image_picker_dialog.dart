import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/provider/image_provider.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget imagePickerDialog(context) {
  var size = MediaQuery.of(context).size;
  var imageProvider = Provider.of<MyImageProvider>(context, listen: false);
  return Material(
    color: Colors.transparent,
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 300,
        width: size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upload Screenshot',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                          padding: EdgeInsets.only(right: 18.0),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                imageProvider.getImage();
              },
              child:
                  Consumer<MyImageProvider>(builder: (context, value, child) {
                if (value.getCNICFile() != null) {
                  return SizedBox(
                    width: size.width * 0.8,
                    height: 150,
                    child: Image.memory(
                      value.getCNICFile()!.readAsBytesSync(),
                      fit: BoxFit.cover,
                      width: size.width * 0.8,
                      height: 150,
                    ),
                  );
                } else {
                  return Container(
                    width: size.width * 0.8,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xff3BCEAC),
                        )),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/image_upload.svg'),
                          const SizedBox(height: 10),
                          const Text(
                            'upload Screenshot',
                            style: TextStyle(fontSize: 16, color: primaryGreen),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
            GestureDetector(
              onTap: () async {
                //Store Image to Firebase
                if (imageProvider.getCNICFile() != null) {
                  Reference firebaseStorageRef = FirebaseStorage.instance
                      .ref()
                      .child("ScreenShotImages")
                      .child(imageProvider.getCNICFile()!.path);
                  final UploadTask task =
                      firebaseStorageRef.putFile(imageProvider.getCNICFile()!);
                  String imagePath = '';
                  task.whenComplete(() async {
                    imagePath = await firebaseStorageRef.getDownloadURL();
                    AppUser updatedUser = AppUser(
                        email: user!.email,
                        password: user!.password,
                        walletAddress: user!.walletAddress,
                        isApproved: user!.isApproved,
                        screenShot: imagePath);
                    FirebaseUtils.updateUser(
                        user: updatedUser, docRef: userRef);
                  });

                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 36,
                width: 106,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(25)),
                child: const Center(
                    child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
