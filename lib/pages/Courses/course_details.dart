import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff19306B),
      appBar: AppBar(
        title: const Text('Course Details'),
        backgroundColor: const Color(0xff19306B),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Text(
                  widget.course.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "P${widget.course.cost.toString()} ",style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${widget.course.duration.toString()}",style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.course.schedule} ",style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${widget.course.venue.toString()}",style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Description: ${widget.course.description}",style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            color: const Color(0xfff1f5fb),
            child: DataTable2(
              bottomMargin: 90,
              isVerticalScrollBarVisible: true,
              minWidth: 600,
              horizontalMargin: 100,
              columns: const [
                DataColumn(label: Text('Student Name')),
                DataColumn(label: Text('Status')),
              ],
              rows: widget.course.students?.isNotEmpty == true
                  ? widget.course.students!
                      .map((student) => buildRow(student))
                      .toList()
                  : [],
            ),
          ),
        ),
      ],
    );
  }

  DataRow2 buildRow(student) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(
        student.name,
      )),
      DataCell(Text(student.status)),
    ]);
  }
}
