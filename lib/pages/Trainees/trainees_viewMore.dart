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
        traineeHeader(),
        const SizedBox(height: 20),
        traineeCourseCard()
      ],
    );
  }

  Widget traineeHeader() {
    return Container(
      decoration: const BoxDecoration(
          // border: Border(bottom: BorderSide(width: 1)),
          // color: Color(0xfff1f5fb),
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                widget.trainee.toString(),
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
        ],
      ),
      // ],
      // ),
    );
  }

  Widget traineeCourseCard() {
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
