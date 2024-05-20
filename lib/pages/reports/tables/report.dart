import 'dart:convert';
import 'package:async/async.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/report.dart';
import 'package:ictc_admin/pages/reports/report_details.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart'
    as pluto_grid_plus_export;
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportTable extends StatefulWidget {
  const ReportTable({super.key});



  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  @override
  void initState() {
    super.initState();
  }

  late final PlutoGridStateManager stateManager;

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
      backgroundColor: const Color(0xfff1f5fb),
      body: Expanded(
          child: Column(
        children: [
          buildDataTable(),
        ],
      )),
    );
  }

  Future<List<PlutoRow>> _fetchRows() async {
    final List<PlutoRow> rows = [];

    final query =
        await Supabase.instance.client.rpc('reports_by_month').select();

    print(query);

    for (Map<String, dynamic> json in query) {
      rows.add(buildRow(json));
    }

    return rows;
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
      field: 'actions',
      renderer: (rendererContext) => rendererContext.cell.value as Widget,
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

  PlutoRow buildRow(Map<String, dynamic> json) {
    final jsonDate = DateTime.parse(json['month_date']);

    return PlutoRow(
      cells: {
        'month': PlutoCell(value: DateFormat.MMMM().format(jsonDate)),
        'totalIncome': PlutoCell(value: json['total_income']),
        'totalExpense': PlutoCell(value: json['total_expenses']),
        'netIncome': PlutoCell(value: json['net_income']),
        'actions': PlutoCell(value: Builder(builder: (context) {
          return Row(
            children: [
              TextButton(
                  onPressed: () async {
                    final reports = await Supabase.instance.client
                        .from('reports_view')
                        .select()
                        .gte('official_receipt_date', jsonDate)
                        .lte(
                            'official_receipt_date',
                            DateTime(
                                jsonDate.year,
                                jsonDate.month,
                                DateUtils.getDaysInMonth(
                                    jsonDate.year, jsonDate.month)))
                        .withConverter((data) =>
                            data.map((e) => Report.fromJson(e)).toList());

                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportDetails(
                              reports: reports,
                              totalIncome: json['total_income'],
                              totalExpenses: json['total_expenses'],
                              netIncome: json['net_income'],
                            ),
                          ));
                    }
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
            stream: StreamGroup.merge([
              Supabase.instance.client
                  .from('payment')
                  .stream(primaryKey: ['id']),
              Supabase.instance.client
                  .from('expense')
                  .stream(primaryKey: ['id'])
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('wait for data');
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.data![0].isEmpty ||
                  snapshot.data![1].isEmpty) {
                    print('data is empty');
                return const Expanded(
                  child: Center(
                    child: Text("No entries."),
                  ),
                );
              }

              print(snapshot.data!);

              return FutureBuilder(
                future: _fetchRows(),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState == ConnectionState.waiting) {
                    print('waiting for row');
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  print('${futureSnapshot.data!.length} rows are here wow');

                  return PlutoGrid(
                      columns: columns,
                      rows: futureSnapshot.data!,
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
