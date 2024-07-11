import 'package:flutter/material.dart';

class TaskProgressItem extends StatefulWidget {
  final String title;
  final String description;
  final int color;

  TaskProgressItem(
      {required this.title, required this.description, required this.color});

  @override
  _TaskProgressItemState createState() => _TaskProgressItemState();
}

class _TaskProgressItemState extends State<TaskProgressItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            side: BorderSide(color: Colors.grey),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
            activeColor: Color(widget.color),
            checkColor: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
