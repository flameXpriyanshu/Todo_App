import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/firepages/homePage.dart';

class AddPages extends StatefulWidget {
  const AddPages({super.key});

  @override
  State<AddPages> createState() => _AddPagesState();
}

class _AddPagesState extends State<AddPages> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  TextEditingController _deadController = TextEditingController();
  String taskType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 25, 51),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.arrow_left),
                color: Colors.white,
                iconSize: 25,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: 4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "New Task",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 10,
                    ),
                    title(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        type("Low Priority", Colors.green),
                        SizedBox(
                          width: 15,
                        ),
                        type("Medium Priority", Colors.yellow),
                        SizedBox(
                          width: 15,
                        ),
                        type("High Priority", Colors.red),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 10,
                    ),
                    description(),
                    SizedBox(
                      height: 25,
                    ),
                    label("DeadLine"),
                    SizedBox(
                      height: 10,
                    ),
                    deadline(),
                    SizedBox(
                      height: 50,
                    ),
                    button(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget type(String txt, Color clr) {
    return InkWell(
      onTap: () {
        setState(() {
          taskType = txt;
        });
      },
      child: Chip(
        backgroundColor: taskType == txt ? Colors.white : clr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          txt,
          style: TextStyle(
            color: taskType == txt ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
    );
  }

  Widget deadline() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _deadController,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Date and Month",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          contentPadding: EdgeInsets.only(left: 15, right: 15),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          contentPadding: EdgeInsets.only(left: 15, right: 15),
        ),
      ),
    );
  }

  Widget label(String txt) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.2),
    );
  }

  Widget description() {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _desController,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
        maxLength: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          contentPadding: EdgeInsets.only(left: 15, right: 15),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("todo").add({
          "title": _titleController.text,
          "task": taskType,
          "description": _desController.text,
          "Deadline": _deadController.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 80,
        margin: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 58, 132, 206),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "Add Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
