import 'package:flutter/material.dart';

class CardCourses extends StatefulWidget {
  const CardCourses({super.key});

  @override
  State<CardCourses> createState() => _CardCoursesState();
}

class _CardCoursesState extends State<CardCourses> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 290,
        height: 140,
        child: InkWell(
          radius: 12,
          hoverDuration: const Duration(milliseconds: 300),
          onTap: () {},
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: const Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "3",
                        style: TextStyle(fontSize: 29, color: Colors.black87),
                      ),
                      Text(
                        "Courses",
                        style: TextStyle(fontSize: 29, color: Colors.black87),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 290,
                    height: 10,
                  ),
                  Text(
                    "Total number of Courses",
                    style: TextStyle(fontSize: 16, fontFamily: "Monsterrat"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
