import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/provider/image_provider.dart';
import 'package:finger_on_app/views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyImageProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: primaryGreen,
            iconTheme: IconThemeData(
              color: primaryGreen,
            )),
        home: const LoginPage(),
      ),
    );
  }
}
