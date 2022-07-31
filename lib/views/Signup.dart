import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/firebase_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPasswordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController walletController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(greenPrimaryValue),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.4,
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  color: Colors.white,
                  height: size.height * 0.2,
                  width: 150,
                ),
              ),
              Container(
                height: 60,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white70))),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.white70),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.white70)),
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(top: 10),
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white70))),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !isPasswordVisible,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white70,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            isPasswordVisible = !isPasswordVisible;
                            setState(() {});
                          },
                          icon: Icon(
                            !isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white,
                          )),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white70)),
                ),
              ),
              Container(
                height: 60,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white70))),
                child: TextFormField(
                  controller: walletController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.white70),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'TRC-20 USDT ADDRESS',
                      hintStyle: TextStyle(color: Colors.white70)),
                ),
              ),
              const Text(
                'Write Carefuly, Funds will be transfered here',
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20, right: size.width * 0.05, bottom: 25),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Already a User? Login Now',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      walletController.text.isNotEmpty) {
                    FirebaseUtils.addUser(AppUser(
                        email: emailController.text,
                        password: passwordController.text,
                        walletAddress: walletController.text,
                        screenShot: '',
                        isApproved: false));
                    var dialog = AlertDialog(
                      title: const Text('Pay for Play'),
                      content: const Text(
                          'You have to pay us Certain Amount at Our Wallet Address (TP1d5wzkY18Y9jVnmtDanPMcmHAx4WAFXK) to be approved and play Finger on App'),
                      actions: [
                        MaterialButton(
                            color: primaryGreen,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                            },
                            child: const Text('Ok')),
                        MaterialButton(
                            color: primaryGreen,
                            onPressed: () {
                              Clipboard.setData(const ClipboardData(
                                  text: "TP1d5wzkY18Y9jVnmtDanPMcmHAx4WAFXK"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Copied to Clipboard')));
                            },
                            child: const Text('Copy to Clipboard')),
                      ],
                    );
                    showDialog(context: context, builder: (context) => dialog);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.white,
                        dismissDirection: DismissDirection.startToEnd,
                        padding: EdgeInsets.all(8),
                        //duration: Duration(seconds: 1),
                        content: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Something is Missing, Please Enter Complete Details',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        )));
                  }
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    'Signup',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
        ),
      )),
    );
  }
}
