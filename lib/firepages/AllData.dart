import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllData extends StatefulWidget {
  const AllData({super.key, required this.data, required this.id});
  final Map<String, dynamic> data;
  final String id;

  @override
  State<AllData> createState() => _AddPagesState();
}

class _AddPagesState extends State<AllData> {
  late TextEditingController _titleController;
  late TextEditingController _desController;
  late TextEditingController _deadController;
  String taskType = "";
  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title =
        widget.data["title"] == null ? "Hey there" : widget.data["title"];
    _titleController = TextEditingController(text: title);

    String descrip = widget.data["description"] == null
        ? "Description"
        : widget.data["description"];
    _desController = TextEditingController(text: descrip);

    String deadtime =
        widget.data["Deadline"] == null ? "Anytime" : widget.data["Deadline"];
    _deadController = TextEditingController(text: deadtime);

    taskType = widget.data["task"];
  }

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
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.arrow_left),
                    color: Colors.white,
                    iconSize: 25,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(Icons.edit),
                        color: edit ? Colors.blue : Colors.white,
                        iconSize: 25,
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("todo")
                              .doc(widget.id)
                              .delete()
                              .then((value) => Navigator.pop(context));
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        iconSize: 25,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Edit Mode" : "View",
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
                      "Your Task",
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
      onTap: edit
          ? () {
              setState(() {
                taskType = txt;
              });
            }
          : null,
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
        enabled: edit,
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
        enabled: edit,
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
        enabled: edit,
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
        FirebaseFirestore.instance.collection("todo").doc(widget.id).update({
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
            edit ? "Update Task" : "Save",
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
