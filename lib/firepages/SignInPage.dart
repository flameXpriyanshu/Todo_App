import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_tracker/firepages/SignUpPage.dart';

import '../Service/auth_Service.dart';
import 'homePage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 34, 25, 51),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 45,
                color: Color.fromARGB(255, 58, 132, 206),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            button("assets/Google.svg", "Continue with Google", () {
              authClass.googleSignIn(context);
            }),
            SizedBox(
              height: 8,
            ),
            button("assets/phone.svg", "Continue with Mobile ", () {}),
            SizedBox(
              height: 9,
            ),
            Text(
              "OR",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 9,
            ),
            textItem("Email", _emailController, false),
            SizedBox(
              height: 10,
            ),
            textItem("Password", _passController, true),
            SizedBox(
              height: 15,
            ),
            SignButton(),
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you don't have an accout?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignUpPage()));
                      },
                      child: Text(
                        " SignUp",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget button(String img, String buttonName, Function() Tap) {
    return InkWell(
      onTap: Tap,
      child: Container(
        width: MediaQuery.of(context).size.width - 65,
        height: 65,
        child: Card(
          color: Color.fromARGB(255, 34, 25, 51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  img,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  buttonName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textItem(String name, TextEditingController controller, bool obscure) {
    return Container(
      color: Color.fromARGB(255, 34, 25, 51),
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 86, 121, 202),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget SignButton() {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _passController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => homePage()),
              (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.shade600,
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }
}
