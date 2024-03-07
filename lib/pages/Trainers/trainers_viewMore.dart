import 'package:flutter/material.dart';

class TrainerViewMore extends StatefulWidget {
  const TrainerViewMore({Key? key});

  @override
  State<TrainerViewMore> createState() => _TrainerViewMoreState();
}

class _TrainerViewMoreState extends State<TrainerViewMore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        trainerHeader(),
        const SizedBox(height: 20),
        trainerCourseCard()
      ],
    );
  }

  Widget trainerHeader() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
          color: Color(0xfff1f5fb),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.all(25),
      child: const Row(
        children: [
          SizedBox(
            width: 200,
            child: Center(
              child: CircleAvatar(
                radius: 120,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Monsterrat",
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.email),
                  Text(
                    " banana@gmail.com",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.phone),
                  Text(
                    " 09452363553",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Monsterrat",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget trainerCourseCard() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
          width: 240,
          height: 120,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Color(0xfff1f5fb),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Intro to Cybersecurity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Monsterrat",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      " January 12, 2024 - February 1, 2024",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Monsterrat",
                        color: Color(0xff153faa),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
