import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/card_button.dart';
import 'package:ictc_admin/pages/card_courses.dart';
import 'package:ictc_admin/pages/card_programs.dart';
import 'package:ictc_admin/pages/card_student.dart';
import 'package:ictc_admin/pages/forms.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
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
                CardPrograms(),
                CardCourses(),
                CardStudent(),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Card(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 72,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(26, 19, 26, 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilledButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Add Program',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        )),
                    Expanded(
                        child: DataTable2(
                      horizontalMargin: 12,
                      columns: const [
                        DataColumn2(label: Text('Title')),
                        DataColumn2(label: Text('Description')),
                        DataColumn2(label: Text('')),
                        DataColumn2(label: Text('Option')),
                      ],
                      rows: [
                        DataRow2(cells: [
                          const DataCell(Text('Advance Figma')),
                          const DataCell(
                              Text('Higher level of fidelity prototypes.')),
                          const DataCell(Text('')),
                          DataCell(Row(
                            children: [
                              FormsLayout(),
                              const Padding(padding: EdgeInsets.all(5)),
                              FilledButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    // If the button is pressed, return green, otherwise blue
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.red;
                                    }
                                    return Colors.red;
                                  }),
                                ),
                                onPressed: () {},
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                        ]),
                      ],
                    ))
                  ],
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}

