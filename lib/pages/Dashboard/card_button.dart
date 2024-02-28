import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  const CardButton({super.key});

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
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
                    "Trainers",
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
                "Total number of Trainers",
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