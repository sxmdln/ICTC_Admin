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
                  "Name: Taylor Batumbakal Swift",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Text("Email Address: tbs@gmail.com",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
                SizedBox(height: 20),
                Text("Contact number: 09065553353",
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
