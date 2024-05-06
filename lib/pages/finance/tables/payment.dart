import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/finance/forms/payment_form.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart' as pluto_grid_plus_export;


class PaymentTable extends StatefulWidget {
  const PaymentTable({super.key});

  @override
  State<PaymentTable> createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
  late Stream<List<Payment>> _payments;
  @override
  void initState() {
    _payments = Seeds.paymentStream();

    super.initState();
  }
  late final PlutoGridStateManager stateManager;

    void _defaultExportGridAsCSV() async {
    String title = "pluto_grid_plus_export";
    var exported = const Utf8Encoder().convert(
        pluto_grid_plus_export.PlutoGridExport.exportCSV(stateManager));
    await FileSaver.instance.saveFile(name: "$title.csv", ext: ".csv", bytes: exported );
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
                  children: [
                    addButton(),
                    csvButton()
                  ],
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
            onPressed: _defaultExportGridAsCSV,
            child: const Text("Export to CSV"));
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
            "Edit an ",
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
          width:450,
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
      title: 'ID',
      field: 'id',
      type: PlutoColumnType.number(),
      minWidth: 50,
      width: 90,
      enableDropToResize: false,
    ),
    PlutoColumn(
      title: 'Program Name',
      field: 'progName',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Course Name',
      field: 'courseName',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Training Fee',
      field: 'trainingFee',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Discount',
      field: 'discount',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'OR Date',
      field: 'orDate',
      readOnly: true,
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'OR Number',
      field: 'orNumber',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Total',
      field: 'amount',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Approved?',
      field: 'isApproved',
      readOnly: true,
      type: PlutoColumnType.text()
    ),
  ];

  PlutoRow buildInRow(Payment payment) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: payment.id),
        'name': PlutoCell(value: payment.toString()),
        'progName': PlutoCell(value: payment.programName),
        'courseName': PlutoCell(value: payment.courseName),
        'trainingFee': PlutoCell(value: payment.trainingFee),
        'discount': PlutoCell(value: payment.discount),
        'orDate': PlutoCell(value: payment.orDate),
        'orNumber': PlutoCell(value: payment.orNumber),
        'amount': PlutoCell(value: payment.amount),
        'isApproved': PlutoCell(value: payment.isApproved),
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
              if (!snapshot.hasData) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return PlutoGrid(
                  columns: inColumns,
                  rows: snapshot.data!.map((e) => buildInRow(e)).toList(),
                  onChanged: (PlutoGridOnChangedEvent event) {
                    print(event);
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                      stateManager = event.stateManager;
                    event.stateManager.setShowColumnFilter(true);
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
