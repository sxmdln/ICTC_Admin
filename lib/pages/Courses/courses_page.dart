import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/register.dart';
import 'package:ictc_admin/pages/Courses/course_details.dart';
import 'package:ictc_admin/pages/courses/course_viewMore.dart';
import 'package:ictc_admin/pages/courses/course_forms.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  CourseViewMore? courseProfileWidget;

  late Payment? payment;
  late Stream<List<Course>> _courses;
  late List<Course> _allCourses;
  late List<Course> _filteredCourses;
  String _searchQuery = "";


  @override
  void initState() {
    _courses = Supabase.instance.client.from('course').stream(primaryKey: ['id']).map((data) {
      final courses = data.map((e) => Course.fromJson(e)).toList();
      _allCourses = courses;
      _filteredCourses = courses;
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
        .count();

    print(response);

    return response.count;
  }

  // @override
  // bool get wantKeepAlive => true;
  // onListRowTap(Course course) {
  //   setState(() => courseProfileWidget =
  //       CourseViewMore(course: course, key: ValueKey<Course>(course)));
  // }

  // void closeProfile() {
  //   setState(() => courseProfileWidget = null);
  // }

    void _filterCourses(String query) {
    final filtered = _allCourses.where((courses) {
      final titleLower = courses.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredCourses = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildSearchBar(),
                    addButton()],
                ),
              ),
              
              buildDataTable(),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.black87,
          thickness: 0.1,
        )
        // ),
        // courseProfileWidget != null
        //     ? Flexible(
        //         flex: 1,
        //         child: Stack(
        //           children: [
        //             courseProfileWidget!,
        //             Container(
        //               padding: const EdgeInsets.only(top: 16, right: 16),
        //               alignment: Alignment.topRight,
        //               child: IconButton(
        //                   onPressed: closeProfile,
        //                   icon: const Icon(Icons.close)),
        //             ),
        //           ],
        //         ),
        //       )
        // : Container(),
      ],
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width:350,
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Search a Course...",
            hintStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 0,
                textBaseline: TextBaseline.alphabetic
                ),
            prefixIcon: const Icon(CupertinoIcons.search, size: 16,),
            prefixIconColor: Colors.black,
          ),
          onChanged: (query) => _filterCourses(query),
        ),
      ),
    );
  }


  Widget buildDataTable() {
    return StreamBuilder(
        stream: _courses,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Expanded(
            child: DataTable2(
              empty: Column(
                children: [
                  Icon(CupertinoIcons.question_circle, size: 50, color: Colors.grey),
                  Text('Add a course to get started!'),
                ],
              ),
              showCheckboxColumn: false,
              showBottomBorder: true,
              sortAscending: false,
              horizontalMargin: 30,
              isVerticalScrollBarVisible: true,
              columns: const [
                DataColumn2(label: Text('Title')),
                DataColumn2(label: Text('Cost')),
                DataColumn2(label: Text('Start Date')),
                DataColumn2(label: Text('End Date')),
                DataColumn2(label: Text('Total Students')),

                DataColumn2(label: Text('Option')),
              ],
              rows: _filteredCourses.map((course) => buildRow(course)).toList(),
              // rows: snapshot.data!.map((e) => buildRow(e)).toList(),
            ),
          );
        });
  }

  DataRow2 buildRow(Course course) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(course.title.toString())),
      DataCell(Text(course.cost.toString())),
      DataCell(Text("${DateFormat.yMMMMd().format(course.startDate!)}")),
      DataCell(Text("${DateFormat.yMMMMd().format(course.endDate!)}")),
      DataCell(FutureBuilder(
                      future: fetchNumberOfPreRegisters(course.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            width:12,  
                              child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff153faa)),
                          ));
                        }

                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'Archivo'),
                        );
                      },
                    ),),

      DataCell(Row(
        children: [
          editButton(course),
          viewButton(course),
        ],
      )),
    ]);
  }

  Widget addButton() {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(155))),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return addDialog();
          },
        );
      },
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: 160, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child:
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          Text(
            'Add a Course',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget addDialog() {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Add a Course",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 550,
          height: MediaQuery.of(context).size.height * 0.6,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CourseForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget editButton(Course course) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog(course);
            },
          );
        },
        child: const Row(
          children: [
            Icon(
              Icons.edit,
              size: 20,
              color: Color(0xff153faa),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Edit"),
          ],
        ));
  }

  Widget editDialog(Course course) {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Edit a Course",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 550,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CourseForm(course: course),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewButton(Course course) {
    return TextButton(
        onPressed: () {
          // var validRegisterObject;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetails(course: course)
              ));
        },
        child: const Row(
          children: [
            Icon(
              Icons.visibility,
              size: 20,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "View",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ));
  }
}
