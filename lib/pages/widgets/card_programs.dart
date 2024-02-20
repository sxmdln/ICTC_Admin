import 'package:flutter/material.dart';

class CardPrograms extends StatefulWidget {
  const CardPrograms({super.key});

  @override
  State<CardPrograms> createState() => _CardProgramsState();
}

class _CardProgramsState extends State<CardPrograms> {
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
                    "Programs",
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
                "Total number of Programs",
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