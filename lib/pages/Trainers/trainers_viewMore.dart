import 'package:flutter/material.dart';
import 'package:ictc_admin/models/trainer.dart';

class TrainerViewMore extends StatefulWidget {
  final Trainer trainer;

  const TrainerViewMore({required this.trainer, super.key});

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 200,
              child: Center(
                child: CircleAvatar(
                  radius: 120,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.trainer.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.trainer.emailAddress,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.trainer.contactNumber,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    //TODO: add handled courses
                    "Handled Courses: Intro to Cybersecurity",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    // TODO: add date
                    "Date: January 12, 2024 - February 1, 2024 ",
                    style: TextStyle(
                      fontSize: 18,
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
