import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.onChange,
    required this.index,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Function onChange;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Colors.green,
                value: check,
                onChanged: (check) {
                  onChange(index);
                },
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.green,
              unselectedWidgetColor: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xff2a2e3d),
                child: Row(children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 33,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        time,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
