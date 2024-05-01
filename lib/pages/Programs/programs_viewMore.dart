import 'package:flutter/material.dart';
import 'package:ictc_admin/models/program.dart';

class ProgramViewMore extends StatefulWidget {
  final Program program;
  const ProgramViewMore({required this.program, super.key});

  @override
  State<ProgramViewMore> createState() => _ProgramViewMoreState();
}

class _ProgramViewMoreState extends State<ProgramViewMore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 45),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // children: [
          //   Text("Preview",
          //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
          // ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 400,
          height: 320,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("PROGRAM",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline)),
                    const SizedBox(height: 30),
                    Text(widget.program.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    Text(
                      widget.program.description ?? "No description set",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent: true,
                          applyHeightToLastDescent: true),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.school_rounded,
                            size: 14, color: Color(0xff153faa)),
                        SizedBox(width: 5),
                        Text(
                          "12 courses", //TODO: add counter functionality  //TODO: view all courses button
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff153faa)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AspectRatio(
                        aspectRatio: 5 / 2,
                        child: Image.asset(
                          'assets/images/program1.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),

        const SizedBox(
            height: 20,
          ),

        buildCourses()
      ],
    );
  }

    Widget buildCourses() {
    return Flexible(
      flex: 8,
      child: Container(
        padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text(
              softWrap: true,
              //name
              "Courses",
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(221, 16, 16, 16),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            //courses
            Expanded(
                flex: 2,
                child: ListView(
                    padding: const EdgeInsets.only(left: 13),
                    children: [
                      programCourseCard(),
                      programCourseCard(),
                      programCourseCard(),
                      programCourseCard(),
                      programCourseCard(),
                      programCourseCard(),
                    ])),
          ],
        ),
      ),
    );
  }

  Widget programCourseCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(0),
      child: const SizedBox(
          width: 240,
          height: 60,
          child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Color.fromARGB(255, 247, 247, 247),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      " Introduction to Cybersecurity", //TODO: add courses of trainer (connected)
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "01/01/2024-02/1/2024",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ))),
    );
  }
}
