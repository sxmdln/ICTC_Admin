import 'package:flutter/material.dart';
import 'package:ictc_admin/models/trainee.dart';

class TraineeViewMore extends StatefulWidget {
  final Trainee trainee;

  const TraineeViewMore({required this.trainee, super.key});

  @override
  State<TraineeViewMore> createState() => _TraineeViewMoreState();
}

class _TraineeViewMoreState extends State<TraineeViewMore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Center(
                child: CircleAvatar(
                  radius: 120,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trainee.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  widget.trainee.emailAddress,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
                SizedBox(height: 20),
                Text(
                  widget.trainee.contactNumber,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
                SizedBox(height: 20),
                Text("Attended Programs: Advance Figma",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
                SizedBox(height: 20),
                Text("Feedback: ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
              ],
            ))
          ],
        )
      ],
    );
  }
}
