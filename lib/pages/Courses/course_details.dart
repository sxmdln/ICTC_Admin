import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/register.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart'
    as pluto_grid_plus_export;
import 'package:html_unescape/html_unescape.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late Future<List<Register>> courseStudents;

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
  }

  Future<List<PlutoRow>> _fetchRows(List<Register> register) async {
    final List<PlutoRow> rows = [];

    for (Register r in register) {
      rows.add(buildInRow(
        register: r,
        student: r.studentId as Trainee,
      ));
    }

    return rows;
  }

  late PlutoGridStateManager stateManager;

  void _defaultExportGridAsCSV() async {
    String title = "pluto_grid_plus_export";
    var exported = const Utf8Encoder().convert(
        pluto_grid_plus_export.PlutoGridExport.exportCSV(stateManager));
    await FileSaver.instance
        .saveFile(name: "$title.csv", ext: ".csv", bytes: exported);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff19306B),
      appBar: AppBar(
        title: const Text('Report Details'),
        backgroundColor: const Color(0xff19306B),
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [csvButton()],
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: const Color(0xff19306B),
                  child: buildBody(context, widget.course),
                ),
                buildInDataTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Text(
                  course.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "P${course.toString()} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${course.duration.toString()}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${course.schedule} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| ${course.venue}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Description: ${HtmlUnescape().convert("${course.description}")}",
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
        const SizedBox(height: 16)
      ],
    );
  }

// IN (Income)
  List<PlutoColumn> inColumns = [
    PlutoColumn(
      title: 'Trainee Name',
      field: 'name',
      readOnly: true,
      type: PlutoColumnType.text(),
      filterHintText: 'Search Trainee',
      renderer: (rendererContext) => rendererContext.cell.value as Widget,
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      hide: true,
      title: 'Email Address',
      field: 'email',
      readOnly: true,
      filterHintText: 'Search email',
      renderer: (rendererContext) => rendererContext.cell.value as Widget,
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      enableEditingMode: false,
      enableDropToResize: false,
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      title: 'Status?',
      field: 'isApproved',
      readOnly: true,
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      renderer: (rendererContext) => rendererContext.cell.value as Widget,
      minWidth: 50,
      width: 90,
    ),
  ];

  PlutoRow buildInRow({required Register register, required Trainee student}) {
    return PlutoRow(
      cells: {
        'name': PlutoCell(
          value: FutureBuilder(
            future: Supabase.instance.client
                .from('student')
                .select('first_name, last_name')
                .eq('id', register.studentId)
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
        'email': PlutoCell(
          value: FutureBuilder(
            future: Supabase.instance.client
                .from('student')
                .select('email')
                .eq('id', register.studentId)
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
          ),
        ),
        'isApproved': PlutoCell(
          value: ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20.0,
            activeBgColors: [
              [Colors.green[800]!],
              [Colors.red[800]!]
            ],
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

              final updatedData = {
                'is_approved': register.status
              }; // Update column name if needed

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
      },
    );
  }

  Widget buildInDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<List<Register>>(
            future: courseStudents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                      SizedBox(
                        height: 23,
                      ),
                      Text(
                        'Please wait...',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.data!.isEmpty) {
                return const Expanded(
                    child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text("No entries found."),
                    ],
                  ),
                ));
              }

              return FutureBuilder(
                future: _fetchRows(snapshot.data!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                            SizedBox(
                              height: 23,
                            ),
                            Text(
                              'Crunching data for you...',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return PlutoGrid(
                      columns: inColumns,
                      rows: snapshot.data!,
                      onChanged: (PlutoGridOnChangedEvent event) {
                        print(event);
                      },
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        stateManager.setShowColumnFilter(true);
                      },
                      rowColorCallback: (rowColorContext) {
                        if (rowColorContext.rowIdx % 2 != 0) {
                          return Colors.grey.withOpacity(0.1);
                        } else {
                          return Colors.transparent;
                        }
                      },
                      configuration: PlutoGridConfiguration(
                        columnFilter: PlutoGridColumnFilterConfig(
                          filters: const [
                            ...FilterHelper.defaultFilters,
                            // custom filter
                            ClassYouImplemented(),
                          ],
                          resolveDefaultColumnFilter: (column, resolver) {
                            if (column.field == 'text') {
                              return resolver<PlutoFilterTypeContains>()
                                  as PlutoFilterType;
                            } else if (column.field == 'number') {
                              return resolver<PlutoFilterTypeGreaterThan>()
                                  as PlutoFilterType;
                            } else if (column.field == 'date') {
                              return resolver<PlutoFilterTypeContains>()
                                  as PlutoFilterType;
                            } else if (column.field == 'select') {
                              return resolver<ClassYouImplemented>()
                                  as PlutoFilterType;
                            }

                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          },
                        ),
                      ));
                },
              );
            }),
      ),
    );
  }

  Widget csvButton() {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff19306B),
          ),
          foregroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white;
            }
            return Colors.white;
          }),
          fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(155)),
        ),
        onPressed: _defaultExportGridAsCSV,
        child: const Row(
          children: [
            Icon(Icons.file_download),
            Text("Export to CSV"),
          ],
        ));
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'Custom contains';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var keys = search!.split(',').map((e) => e.toUpperCase()).toList();

        return keys.contains(base!.toUpperCase());
      };

  const ClassYouImplemented();
}
