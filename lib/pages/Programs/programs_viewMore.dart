import 'package:flutter/material.dart';

class ProgramViewMore extends StatefulWidget {
  const ProgramViewMore({super.key});

  @override
  State<ProgramViewMore> createState() => _ProgramViewMoreState();
}

class _ProgramViewMoreState extends State<ProgramViewMore> {
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
