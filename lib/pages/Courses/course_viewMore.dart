import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourseViewMore extends StatefulWidget {
  final Course course;
  const CourseViewMore({required this.course, super.key});

  @override
  State<CourseViewMore> createState() => _CourseViewMoreState();
}

class _CourseViewMoreState extends State<CourseViewMore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("COURSES",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.course.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.pesoSign, color: Color(0xff153faa),), 
                        SizedBox(width: 5),
                        Text(
                          widget.course.cost
                              .toString(),
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff153faa)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  widget.course.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: true,
                      applyHeightToLastDescent: true),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.school_rounded,
                        size: 14, color: Color(0xff153faa)),
                    SizedBox(width: 5),
                    Text(
                      widget.course.cost
                          .toString(), // TODO: TOTAL number of enrollees!!!!
                      style: TextStyle(fontSize: 12, color: Color(0xff153faa)),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: AspectRatio(
                    aspectRatio: 20 / 10,
                    child: Image.asset(
                      'assets/images/program1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
