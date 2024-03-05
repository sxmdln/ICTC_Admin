import 'package:flutter/material.dart';

class TraineeViewMore extends StatefulWidget {
  const TraineeViewMore({super.key});

  @override
  State<TraineeViewMore> createState() => _TraineeViewMoreState();
}

class _TraineeViewMoreState extends State<TraineeViewMore> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name: ",
          style: TextStyle(
              fontSize: 18, fontFamily: "Monsterrat", color: Colors.black),
        ),
        Text("Attended Programs: ",
            style: TextStyle(
                fontSize: 18, fontFamily: "Monsterrat", color: Colors.black)),
      ],
    );
  }
}