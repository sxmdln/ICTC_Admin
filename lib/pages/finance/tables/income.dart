import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/sale.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:pluto_grid/pluto_grid.dart';

class IncomeTable extends StatefulWidget {
  const IncomeTable({super.key});

  @override
  State<IncomeTable> createState() => _IncomeTableState();
}

class _IncomeTableState extends State<IncomeTable> {
  late Stream<List<Income>> _incomes;
  @override
  void initState() {
    _incomes = Seeds.incomeStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildInDataTable();
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
      title: 'Name',
      field: 'name',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Total Students',
      field: 'totalStudents',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Schedule',
      field: 'schedule',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Discount Total',
      field: 'discountTotal',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Income Total',
      field: 'incomeTotal',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
  ];

  PlutoRow buildInRow(Income income) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: income.id),
        'name': PlutoCell(value: income.toString()),
        'totalStudents': PlutoCell(value: income.totalStudents),
        'schedule': PlutoCell(value: income.schedule),
        'discountTotal': PlutoCell(value: income.discountTotal),
        'incomeTotal': PlutoCell(value: income.incomeTotal),
      },
    );
  }

  Widget buildInDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
            stream: _incomes,
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
