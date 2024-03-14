import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/courses/course_viewMore.dart';
import 'package:ictc_admin/pages/courses/course_forms.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with AutomaticKeepAliveClientMixin {
  CourseViewMore? courseProfileWidget;

  late List<Course> courses;

  @override
  void initState() {
    // TODO: implement initState
    courses = Seeds.courses;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  onListRowTap(Course course) {
    setState(() => courseProfileWidget =
        CourseViewMore(course: course, key: ValueKey<Course>(course)));
  }

  void closeProfile() {
    setState(() => courseProfileWidget = null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  children: [addButton()],
                ),
              ),
              buildDataTable(),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        courseProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    courseProfileWidget!,
                    Container(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: closeProfile,
                          icon: const Icon(Icons.close)),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buildDataTable() {
    return Expanded(
      child: DataTable2(
        showCheckboxColumn: false,
        showBottomBorder: true,
        horizontalMargin: 30,
        isVerticalScrollBarVisible: true,
        columns: const [
          DataColumn2(label: Text('Title')),
          DataColumn2(label: Text('Cost')),
          DataColumn2(label: Text('')),
          DataColumn2(label: Text('Option')),
        ],
        rows: courses.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  DataRow2 buildRow(Course course) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(course.title)),
      DataCell(Text(course.cost.toString())),
      const DataCell(Text('')),
      DataCell(Row(
        children: [
          editButton(),
          const Padding(padding: EdgeInsets.all(5)),
          viewButton(course)
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
      contentPadding: EdgeInsets.only(left: 20, right: 30, top: 40),
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
            "Add a Program",
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
          height: MediaQuery.of(context).size.height * 0.4,
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


  Widget editButton() {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog();
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


  Widget editDialog() {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: EdgeInsets.only(left: 20, right: 30, top: 40),
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
            "Edit a Program",
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
          height: MediaQuery.of(context).size.height * 0.4,
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

  Widget viewButton(Course course) {
    return TextButton(
        onPressed: () {
          onListRowTap(course);
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       contentPadding: const EdgeInsets.all(0),
          //       backgroundColor: Colors.transparent,
          //       content: CourseViewMore(course: course),
          //     );
          //   },
          // );
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
