import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_tracker/Service/auth_Service.dart';
import 'package:task_tracker/firepages/SignInPage.dart';
import 'package:task_tracker/firepages/homePage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 45,
                color: Color.fromARGB(255, 58, 132, 206),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            button("assets/Google.svg", "Continue with Google", () async {
              await authClass.googleSignIn(context);
            }),
            const SizedBox(
              height: 8,
            ),
            button("assets/phone.svg", "Continue with Mobile ", () {}),
            const SizedBox(
              height: 9,
            ),
            const Text(
              "OR",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 9,
            ),
            textItem("Email", _emailController, false),
            const SizedBox(
              height: 10,
            ),
            textItem("Password", _passController, true),
            const SizedBox(
              height: 15,
            ),
            SignButton(),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "If you already have an accout?",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SignInPage()),
                        (route) => false);
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
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
        color: const Color.fromARGB(255, 34, 25, 51),
        width: MediaQuery.of(context).size.width - 65,
        height: 65,
        child: Card(
          color: Color.fromARGB(255, 34, 25, 51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
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
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  buttonName,
                  style: const TextStyle(
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
      color: const Color.fromARGB(255, 34, 25, 51),
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 86, 121, 202),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
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
        setState(() {
          circular = false;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text, password: _passController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
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
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }
}
