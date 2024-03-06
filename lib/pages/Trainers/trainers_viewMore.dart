import 'package:flutter/material.dart';

class TrainerViewMore extends StatefulWidget {
  const TrainerViewMore({Key? key});

  @override
  State<TrainerViewMore> createState() => _TrainerViewMoreState();
}

class _TrainerViewMoreState extends State<TrainerViewMore> {
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
                  SizedBox(height: 20),
                  Text(
                    "Name: Bananakin Skywalker",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email address: banana@gmail.com",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Contact number: 09452363553",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Handled Courses: Intro to Cybersecurity",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Date: January 12, 2024 - February 1, 2024 ",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
