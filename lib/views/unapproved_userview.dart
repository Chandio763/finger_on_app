import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/image_picker_dialog.dart';
import 'package:finger_on_app/views/login_page.dart';
import 'package:flutter/material.dart';

class UnApprovedScreen extends StatefulWidget {
  UnApprovedScreen({Key? key}) : super(key: key);

  @override
  State<UnApprovedScreen> createState() => _UnApprovedScreenState();
}

class _UnApprovedScreenState extends State<UnApprovedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sorry for Inconvenience'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return imagePickerDialog(context);
            },
          );
        },
        child: Container(
          height: 45,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: primaryGreen, borderRadius: BorderRadius.circular(25)),
          child: const Center(
            child: Text('Upload Paid Screenshot'),
          ),
        ),
      ),
      body: Container(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: const Text(
                'Your Account is Not Approved. You have not submitted the amount or screenshot of amount. If you have paid and sent the screenshot, just login the app again'),
          ),
        ),
      ),
    );
  }
}
