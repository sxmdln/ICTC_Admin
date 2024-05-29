import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/pages/courses/course_details.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Payment? payment;
  late Stream<List<Course>> courses;
  @override
  void initState() {
    courses = Supabase.instance.client
        .from('course')
        .stream(primaryKey: ['id'])
        .limit(9)
        .order('start_date', ascending: true)
        .map((data) {
          final courses = data.map((e) => Course.fromJson(e)).toList();
          return courses;
        });
    super.initState();
  }

  Future<int> fetchNumberOfPreRegisters(int courseId) async {
    print('fetching number of pre-registers');
    final response = await Supabase.instance.client
        .from('registration')
        .select('id')
        .eq('course_id', courseId)
        .eq('is_approved', false)
        .count();

    print(response);

    return response.count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff1f5fb),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Upcoming Courses',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(flex: 1, child: buildUpcomingCourses())
          ],
        ));
  }

  Widget buildUpcomingCourses() {
    return StreamBuilder(
      stream: courses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator.adaptive(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff153faa))),
                    SizedBox(
                      height: 23,
                    ),
                    Text(
                      'Please wait...',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ));
        }

        return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.3,
                childAspectRatio: 2.3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10),
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final course = snapshot.data![index];
              return buildCourseCard(course);
            });
      },
    );

    // }
    // );
  }

  Widget buildCourseCard(Course course) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CourseDetails(course: course)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                Text(
                  course.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Schedule: ${DateFormat.yMMMMd().format(course.startDate!)} - ${DateFormat.yMMMMd().format(course.endDate!)} ",
                ),
                Text(
                  "Venue: ${course.venue}",
                ),
                const SizedBox(height: 20),

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ">> See More",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff153faa),
                          decoration: TextDecoration.underline),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Chip(
                elevation: 1,
                backgroundColor: const Color(0xff153faa),
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: fetchNumberOfPreRegisters(course.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff153faa)),
                            strokeWidth: 4,
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ));
                        }

                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Archivo'),
                        );
                      },
                    ),
                    const Text(
                      "Students",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 7,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
