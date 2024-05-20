import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/pages/finance/forms/payment_form.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart'
    as pluto_grid_plus_export;
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentTable extends StatefulWidget {
  const PaymentTable({super.key});

  @override
  State<PaymentTable> createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
  late Stream<List<Payment>> _payments;
  @override
  void initState() {
    _payments = Supabase.instance.client.from('payment').stream(primaryKey: [
      'id'
    ]).map((data) => data.map((e) => Payment.fromJson(e)).toList());

    super.initState();
  }

  Future<List<PlutoRow>> _fetchRows(List<Payment> payments) async {
    final futures = payments.map((p) async {
      // Fetch student, program, and course in parallel
      final studentFuture = p.student;
      final programFuture = p.program;
      final courseFuture = p.course;

      // Await all of them together
      final student = await studentFuture;
      final program = await programFuture;
      final course = await courseFuture;

      return buildInRow(
        payment: p,
        student: student,
        program: program,
        course: course,
      );
    }).toList();

    final rows = await Future.wait(futures);

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
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [addButton(), csvButton()],
                ),
              ),
              buildInDataTable(),
            ],
          ),
        ),
      ],
    );
  }

  Widget csvButton() {
    return ElevatedButton(
        onPressed: _defaultExportGridAsCSV, child: const Text("Export to CSV"));
  }

  Widget editButton(Payment payment) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog(payment);
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

  Widget editDialog(Payment payment) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
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
                Navigator.of(context, rootNavigator: true).pop(editDialog);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Edit Income",
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
          width: 450,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PaymentForm(payment: payment),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(255, 57, 167, 74);
              }
              return const Color.fromARGB(255, 33, 175, 23);
            },
          ),
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(145))),
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
            maxWidth: 1000,
            minWidth: 100,
            minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Row(children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          Text(
            'Add Income',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget addDialog() {
    return AlertDialog(
      surfaceTintColor: Colors.white,
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
                Navigator.of(context, rootNavigator: true).pop(addDialog);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Add an Income",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 1,
        child: SizedBox(
          width: 450,
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PaymentForm(),
                ],
              ),
            ),
          ),
        ),
      ),
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
      title: 'Program Name',
      field: 'progName',
      filterHintText: 'Search Program',
      readOnly: true,
      type: PlutoColumnType.text(),
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
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
      title: 'Trainee Name',
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
      type: PlutoColumnType.number(
        negative: false,
        format: 'P#,###',
      ),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Discount',
      field: 'discount',
      readOnly: true,
      type: PlutoColumnType.number(),
      backgroundColor: Colors.orange.withOpacity(0.1),
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
    PlutoColumn(
      title: 'OR Date',
      field: 'orDate',
      readOnly: true,
      filterHintText: 'Search by date',
      type: PlutoColumnType.date(format: 'yMMMMd'),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'OR Number',
      filterHintText: 'Search an OR #',
      field: 'orNumber',
      readOnly: true,
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableEditingMode: false,
    ),
    PlutoColumn(
      readOnly: true,
      title: 'Actions',
      field: 'actions',
      renderer: (rendererContext) => rendererContext.cell.value as Widget,
      type: PlutoColumnType.text(),
      enableEditingMode: false,
      enableAutoEditing: false,
      filterWidget: Container(
        color: Colors.white,
      ),
      enableFilterMenuItem: false,
      enableRowDrag: false,
      enableRowChecked: false,
      minWidth: 50,
      width: 120,
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableDropToResize: false,
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
        'name': PlutoCell(value: student.toString()),
        'progName': PlutoCell(value: program.title),
        'courseName': PlutoCell(value: course.title),
        'trainingFee': PlutoCell(value: course.cost),
        'discount': PlutoCell(value: payment.discount),
        'amount': PlutoCell(value: payment.totalAmount),
        'isApproved': PlutoCell(value: payment.approved),
        'orDate': PlutoCell(value: payment.orDate),
        'orNumber': PlutoCell(value: payment.orNumber),
        'actions': PlutoCell(value: Builder(builder: (context) {
          return Row(
            children: [
              editButton(payment),
            ],
          );
        })),
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
                        color: Colors.grey,
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
                                    Color(0xff153faa))),
                            SizedBox(
                              height: 23,
                            ),
                            Text(
                              'Crunching data for you...',
                              style: TextStyle(fontSize: 12),
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
