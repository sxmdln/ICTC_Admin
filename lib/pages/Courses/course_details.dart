import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
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

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late Stream<List<Payment>> _payments;
  @override
  void initState() {
    _payments = Supabase.instance.client
        .from('payment')
        .stream(primaryKey: ['id'])
        .eq('course_id', widget.course.id as Object)
        .map((data) => data.map((e) => Payment.fromJson(e)).toList());

    super.initState();
  }

  Future<List<PlutoRow>> _fetchRows(List<Payment> payments) async {
    final List<PlutoRow> rows = [];

    for (Payment p in payments) {
      rows.add(buildInRow(
          payment: p,
          student: await p.student,
          program: await p.program,
          course: await p.course));
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
                  color: Color(0xff19306B),
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
      hide: true,
      title: 'ID',
      field: 'id',
      type: PlutoColumnType.number(),
      minWidth: 50,
      width: 90,
      enableDropToResize: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'OR Date',
      field: 'orDate',
      readOnly: true,
      filterHintText: 'Search by date',
      type: PlutoColumnType.date(),
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'OR Number',
      filterHintText: 'Search an OR #',
      field: 'orNumber',
      readOnly: true,
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      hide: true,
      title: 'Course Name',
      field: 'courseName',
      readOnly: true,
      filterHintText: 'Search Course',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      readOnly: true,
      type: PlutoColumnType.text(),
      filterHintText: 'Search Trainee',
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Training Fee',
      field: 'trainingFee',
      readOnly: true,
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      type: PlutoColumnType.number(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Discount',
      field: 'discount',
      readOnly: true,
      backgroundColor: Colors.orange.withOpacity(0.1),
      type: PlutoColumnType.number(),
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          format: 'P#,###',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Total Discount',
                style: TextStyle(color: Colors.orangeAccent),
              ),
              const TextSpan(text: ' : '),
              TextSpan(
                  text: text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ];
          },
        );
      },
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      minWidth: 50,
      width: 120,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Amount',
      field: 'amount',
      readOnly: true,
      type: PlutoColumnType.number(),
      backgroundColor: Colors.green.withOpacity(0.1),
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          format: 'P#,###',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Total Income',
                style: TextStyle(color: Colors.green),
              ),
              const TextSpan(text: ' : '),
              TextSpan(
                  text: text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ];
          },
        );
      },
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
      enableDropToResize: false,
      minWidth: 50,
      width: 120,
    ),
    PlutoColumn(
      enableEditingMode: false,
      enableDropToResize: false,
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      title: 'Approved?',
      field: 'isApproved',
      readOnly: true,
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      renderer: (rendererContext) => rendererContext.cell.value == true
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.close,
              color: Colors.red,
            ),
      minWidth: 50,
      width: 90,
    ),
  ];

  PlutoRow buildInRow(
      {required Payment payment,
      required Trainee student,
      required Program program,
      required Course course}) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: payment.id),
        'orDate': PlutoCell(value: payment.orDate),
        'orNumber': PlutoCell(value: payment.orNumber),
        'name': PlutoCell(value: student.toString()),
        'courseName': PlutoCell(value: course.title),
        'trainingFee': PlutoCell(value: course.cost),
        'discount': PlutoCell(value: payment.discount),
        'amount': PlutoCell(value: payment.totalAmount),
        'isApproved': PlutoCell(value: payment.approved),
      },
    );
  }

  Widget buildInDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
            stream: _payments,
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
            Color(0xff19306B),
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
        child: Row(
          children: [
            Icon(Icons.file_download),
            const Text("Export to CSV"),
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
