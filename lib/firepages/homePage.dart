import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/Custom/TaskCard.dart';
import 'package:task_tracker/firepages/AddPages.dart';
import 'package:task_tracker/firepages/AllData.dart';
import 'package:task_tracker/firepages/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Service/auth_Service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int myindex = 0;
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("todo")
      .orderBy("task", descending: true)
      .snapshots();
  List<Select> selected = []; //for the state of the state checkboxes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 25, 51),
        title: const Text(
          "Task List",
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await authClass.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const SignUpPage()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
            color: Colors.redAccent,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const homePage()));
              },
              child: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            label: 'New Task',
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const AddPages()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const BottomNavigationBarItem(
            label: 'Setting',
            icon: InkWell(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          //don't need to call the app again and again,it will automatically update the app state
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> documents =
                      snapshot.data!.docs[index].data() as Map<String,
                          dynamic>; //typecasting into a map, we have in a json type so thats why using map
                  switch (documents["task"]) {
                    case "Low Priority":
                      iconData = Icons.alarm;
                      iconColor = Colors.green;
                      break;
                    case "Medium Priority":
                      iconData = Icons.alarm;
                      iconColor = Colors.yellow;
                      break;
                    case "High Priority":
                      iconData = Icons.alarm;
                      iconColor = Colors.red;
                      break;
                    default:
                      iconData = Icons.alarm;
                      iconColor = Colors.blue;
                  }
                  selected.add(Select(
                      id: snapshot.data!.docs[index].id,
                      checkValue:
                          false)); //providing access from homepage to TaskCard
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AllData(
                                  data: documents,
                                  id: snapshot.data!.docs[index]
                                      .id))); //with the help of snapshot we are getting particular id
                    },
                    child: TaskCard(
                      // ignore: prefer_if_null_operators
                      title: documents["title"] == null
                          ? "Hey There"
                          : documents["title"],
                      check: selected[index].checkValue,
                      iconColor: iconColor,
                      iconData: iconData,
                      // ignore: prefer_if_null_operators
                      time: documents["Deadline"] == null
                          ? "Anytime"
                          : documents["Deadline"],
                      index: index,
                      onChange: onChange,
                    ),
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    //to manage the state of checkbox
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  late String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}

//          

