import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late final Future<List<Register>> courseStudents;

  @override
  void initState() {
    courseStudents = Supabase.instance.client
        .from('registration')
        .select()
        .eq('course_id', widget.course.id!)
        .withConverter((data) {
          print(data);
      return data.map((e) => Register.fromJson(e)).toList();
    });

    super.initState();
    // print(courseStudents.toString());
  }

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
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "P${widget.course.cost.toString()} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${widget.course.duration.toString()}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.course.schedule} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${widget.course.venue.toString()}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Description: ${HtmlUnescape().convert("${widget.course.description}")}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: 
          FutureBuilder<List<Register>>(
            future: courseStudents,
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());

              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));

              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No students in this course',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
                
              } else {
                return Container(
                  color: const Color(0xfff1f5fb),
                  child: DataTable2(
                      showCheckboxColumn: false,
                      bottomMargin: 90,
                      isVerticalScrollBarVisible: true,
                      minWidth: 600,
                      horizontalMargin: 100,
                      columns: const [
                        DataColumn(label: Text('Student Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: snapshot.data!
                          .map((register) => buildRow(register))
                          .toList()),
                );
              }
            },
          ),
        ),

      ],
    );
  }

DataRow2 buildRow(Register register) {
  final studentId = register.studentId;

  return DataRow2(
    onSelectChanged: (selected) {},
    cells: [
      DataCell(
        FutureBuilder(
          future: Supabase.instance.client
              .from('student')
              .select('first_name, last_name')
              .eq('id', studentId)
              .single()
              .then((response) {
            final firstName = response['first_name'] as String;
            final lastName = response['last_name'] as String;
            final fullName = '$firstName $lastName';
            return fullName;
          }),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(snapshot.data ?? '');
            }
          },
        ),
      ),
      DataCell(FutureBuilder(
        future: Supabase.instance.client
            .from('student')
            .select('email')
            .eq('id', studentId)
            .single()
            .then((response) {
          final email = response['email'] as String;
          return email;
        }),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(snapshot.data ?? '');
          }
        },
      )),
      DataCell(
        ToggleSwitch(
          minWidth: 90.0,
          cornerRadius: 20.0,
          activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          initialLabelIndex: register.status ? 0 : 1,
          totalSwitches: 2,
          labels: ['Complete', 'Pending'],
          radiusStyle: true,

          onToggle: (index) {
            setState(() {
              register.status = index == 0;
            });

            final updatedData = {'is_approved': register.status}; // Update column name if needed

            Supabase.instance.client
                .from('registration')
                .update(updatedData)
                .eq('id', register.id as Object)
                .then((_) {
              // Update succeeded
              print('Status updated successfully');
            }).catchError((error) {
              // Handle update error
              print('Error updating status: $error');
            });
          },


        ),
      ),
    ],
  );
}



}