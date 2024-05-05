import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/report.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/Courses/course_details.dart';
import 'package:ictc_admin/pages/reports/report_details.dart';
import 'package:pluto_grid/pluto_grid.dart';

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
      hide: true,
      title: 'ID',
      field: 'id',
      readOnly: true,
      type: PlutoColumnType.number(),
      minWidth: 50,
      width: 90,
      enableDropToResize: false,
    ),
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
      title: 'Net Worth',
      field: 'netWorth',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      readOnly: true,
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
        'netWorth': PlutoCell(value: report.netWorth),
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
