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
        trainerHeader(),
        // const SizedBox(height: 20),
        // trainerCourseCard(),
        // trainerCourseCard2()
      ],
    );
  }

  Widget trainerHeader() {
    return Container(
      decoration: const BoxDecoration(
          // border: Border(bottom: BorderSide(width: 1)),
          // color: Color(0xfff1f5fb),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              //image
              const SizedBox(
                width: 100,
                height: 80,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 120,
                  ),
                ),
              ),
              const SizedBox(
                //spacing
                height: 20,
              ),
              Text(
                //name
                widget.trainer.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),

              //email
              //desc
              //edit
              //total courses, total trained students(trainees),
              //school
              //credentials
              //feedbacks
            ],
          ),
          Container(
            // color: Colors.red.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Courses",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                // SliverList(delegate:),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [trainerCourseCard(),trainerCourseCard()],),
                ],
            ),
          ),
          // const SizedBox(
          //   width: 200,
          //   child: Center(
          //     child: CircleAvatar(
          //       radius: 120,
          //     ),
          //   ),
          // ),
          // const Padding(padding: EdgeInsets.all(20)),
          // Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   Text(
          //     widget.trainer.toString(),
          //     style: const TextStyle(
          //         fontSize: 30,
          //         fontFamily: "Monsterrat",
          //         color: Colors.black,
          //         fontWeight: FontWeight.w600),
          //   ),
          //   const SizedBox(height: 20),
          // Row(
          //   children: [
          //     const Icon(Icons.email),
          //     Text(
          //       widget.trainer.emailAddress,
          //       style: const TextStyle(
          //         fontSize: 18,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     const Icon(Icons.phone),
          //     Text(
          //       widget.trainer.contactNumber,
          //       style: const TextStyle(
          //         fontSize: 18,
          //         fontFamily: "Monsterrat",
          //         color: Colors.black,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      // ],
      // ),
    );
  }

  Widget trainerCourseCard() {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: SizedBox(
          width: 150,
          height: 90,
          child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Introduction to Cybersecurity", //TODO: add courses of trainer (connected)
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "01/01/2024-02/1/2024",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
