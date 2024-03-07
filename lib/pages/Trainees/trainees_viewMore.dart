import 'package:flutter/material.dart';

class TraineeViewMore extends StatefulWidget {
  const TraineeViewMore({super.key});

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
        traineeHeader(),
        const SizedBox(height: 20),
        traineeCourseCard()
      ],
    );
  }

  Widget traineeHeader() {
    return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
          color: Color(0xfff1f5fb),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
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
                  " Taylor Batumbakal Swift",
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
                    Text("Email Address: tbs@gmail.com",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Monsterrat",
                            color: Colors.black)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(" 09065553353",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Monsterrat",
                                color: Colors.black)),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget traineeCourseCard() {
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
                Text(" Advance Figma",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Monsterrat",
                        color: Colors.black)),
                SizedBox(height: 10),
                Text(" January 12, 2024 - February 1, 2024",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Monsterrat",
                        color: Color(0xff153faa))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Feedback: ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Monsterrat",
                          color: Color(0xff153faa)),
                    ),
                    Icon(Icons.check, color: Colors.green, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
