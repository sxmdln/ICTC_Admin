import 'package:flutter/material.dart';
import 'package:ictc_admin/pages/dashboard/card_button.dart';
import 'package:ictc_admin/pages/dashboard/card_courses.dart';
import 'package:ictc_admin/pages/dashboard/card_programs.dart';
import 'package:ictc_admin/pages/dashboard/card_student.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 1350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardButton(),
                CardCourses(),
                CardPrograms(),
                CardStudent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
