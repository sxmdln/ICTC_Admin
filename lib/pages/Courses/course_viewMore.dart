import 'package:flutter/material.dart';

class CourseViewMore extends StatefulWidget {
  const CourseViewMore({super.key});

  @override
  State<CourseViewMore> createState() => _CourseViewMoreState();
}

class _CourseViewMoreState extends State<CourseViewMore> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title: ",
          style: TextStyle(
              fontSize: 18, fontFamily: "Monsterrat", color: Colors.black),
        ),
        Text("Description: ",
            style: TextStyle(
                fontSize: 18, fontFamily: "Monsterrat", color: Colors.black)),
        Text("Courses: ",
            style: TextStyle(
                fontSize: 18, fontFamily: "Monsterrat", color: Colors.black))
      ],
    );
  }
}