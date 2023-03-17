import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_tracker/Service/auth_Service.dart';
import 'package:task_tracker/firepages/AddPages.dart';
import 'package:task_tracker/firepages/homePage.dart';

import 'firepages/SignInPage.dart';
import 'firepages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    print("token");
    if (token != null) {
      setState(() {
        currentPage = const homePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}
