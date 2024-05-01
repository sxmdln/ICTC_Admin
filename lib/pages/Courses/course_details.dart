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
      appBar: AppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.course.title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Expanded(
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Student Name')),
              DataColumn(label: Text('Status')),
            ],
            rows: widget.course.students?.isNotEmpty == true
                ? widget.course.students!
                    .map((student) => DataRow(
                          cells: [
                            DataCell(Text(student.name)),
                            DataCell(Text(student.status)),
                          ],
                        ))
                    .toList()
                : [],
          ),
        ),
      ),
    ],
  );
}

}
