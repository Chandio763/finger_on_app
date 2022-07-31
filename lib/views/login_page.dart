// ignore_for_file: use_build_context_synchronously

import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/user_model.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:finger_on_app/views/Signup.dart';
import 'package:finger_on_app/views/dashboard.dart';
import 'package:finger_on_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAdmin = false;
  String loginText = 'Login as Admin';
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
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
                          'SignUp Instead? ',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (isAdmin) {
                    var res = await FirebaseUtils.validateAdmin(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (res['isValid']) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          dismissDirection: DismissDirection.startToEnd,
                          padding: EdgeInsets.all(8),
                          duration: Duration(seconds: 1),
                          content: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Login Successful',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminDashboard(),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          dismissDirection: DismissDirection.startToEnd,
                          padding: EdgeInsets.all(8),
                          duration: Duration(seconds: 1),
                          content: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Invalid Credentials',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )));
                    }
                  } else {
                    var res = await FirebaseUtils.validateUser(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (res['isValid']) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          dismissDirection: DismissDirection.startToEnd,
                          padding: EdgeInsets.all(8),
                          duration: Duration(seconds: 1),
                          content: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Login Successful',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyHomePage(isAdmin: false),
                      ));
                      // } else if (res['isValid'] && !res['isApproved']) {
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //       backgroundColor: Colors.white,
                      //       dismissDirection: DismissDirection.startToEnd,
                      //       padding: EdgeInsets.all(8),
                      //       //duration: Duration(seconds: 1),
                      //       content: SizedBox(
                      //         height: 40,
                      //         child: Center(
                      //           child: Text(
                      //             'Logged In, Account is pending, Please share amount at given Wallet to be approved',
                      //             style: TextStyle(color: Colors.green),
                      //           ),
                      //         ),
                      //       )));
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const MyHomePage(isAdmin: false),
                      //   ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.white,
                          dismissDirection: DismissDirection.startToEnd,
                          padding: EdgeInsets.all(8),
                          duration: Duration(seconds: 1),
                          content: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Invalid Credentials',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )));
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    isAdmin ? 'Login as Admin' : 'Login as User',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isAdmin) {
                    loginText = 'Login as Admin';
                    isAdmin = false;
                    setState(() {});
                  } else {
                    loginText = 'Login as User';
                    isAdmin = true;
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(loginText,
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      )),
    );
  }
}
