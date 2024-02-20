import 'package:flutter/material.dart';

class CardStudent extends StatefulWidget {
  const CardStudent({super.key});

  @override
  State<CardStudent> createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 140,
      child: InkWell(
        onTap: () {},
        child: const Card(
        child: Padding(padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "3", 
                    style: TextStyle(
                      fontSize: 29,
                      fontFamily: "Monsterrat"
                    ),
                  ),
                  Text(
                    "Trainees",
                    style: TextStyle(
                      fontSize: 29,
                      fontFamily: "Monsterrat"
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 290,
                height: 10,
              ),
              Text(
                "Total number of Trainees",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Monsterrat"
                ),
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}