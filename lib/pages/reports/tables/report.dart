import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/report.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/reports/report_details.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart' as pluto_grid_plus_export;

class ReportTable extends StatefulWidget {
  const ReportTable({super.key});



  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  late Stream<List<Report>> _reports;
  @override
  void initState() {
    _reports = Seeds.reportStream();




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
    return Scaffold(
      backgroundColor: const Color(0xfff1f5fb),
      body: Expanded(child: Column(
        children: [
          Row(),
          buildDataTable(),
        ],
      )),
    );
  }

  // FIN (Finance)
  List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Month',
      field: 'month',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Total Income',
      field: 'totalIncome',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Total Expense',
      field: 'totalExpense',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Net Income',
      field: 'netIncome',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      readOnly: true,
      filterWidget: Container(color: Colors.white,),
      title: 'Actions',
      field: 'actions',renderer: (rendererContext) => rendererContext.cell.value as Widget,
      type: PlutoColumnType.text(),
      enableEditingMode: false,
      enableAutoEditing: false,
      enableRowDrag: false,
      enableFilterMenuItem: false,
      enableRowChecked: false,
      width: 250,
      minWidth: 175,
    ),
  ];

  PlutoRow buildRow(Report report) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: report.id),
        'month': PlutoCell(value: report.date),
        'totalIncome': PlutoCell(value: report.totalIncome),
        'totalExpense': PlutoCell(value: report.totalExpense),
        'netIncome': PlutoCell(value: report.netIncome),
        'actions': PlutoCell(value: Builder(builder: (context) {
          return Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportDetails(report: report),
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
                  ))
            ],
          );
        })),
      },
    );
  }

  Widget buildDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
            stream: _reports,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return PlutoGrid(
                  columns: columns,
                  rows: snapshot.data!.map((e) => buildRow(e)).toList(),
                  onChanged: (PlutoGridOnChangedEvent event) {
                    print(event);
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
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
