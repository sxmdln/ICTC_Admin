import 'package:flutter/cupertino.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ExpenseTable extends StatefulWidget {
  const ExpenseTable({super.key});

  @override
  State<ExpenseTable> createState() => _ExpenseTableState();
}

class _ExpenseTableState extends State<ExpenseTable> {
  late Stream<List<Expense>> _expenses;
  @override
  void initState() {
    _expenses = Seeds.expenseStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildOutDataTable();
  }

  // OUT (Expenses)
  List<PlutoColumn> outColumns = [
    PlutoColumn(
      title: 'ID',
      field: 'id',
      type: PlutoColumnType.number(),
      readOnly: true,
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
      title: 'Course Name',
      field: 'courseName',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Date',
      field: 'date',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Cost',
      field: 'cost',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
  ];

  PlutoRow buildOutRow(Expense expense) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: expense.id),
        'name': PlutoCell(value: expense.date),
        'courseName': PlutoCell(value: expense.courseName),
        'date': PlutoCell(value: expense.date),
        'cost': PlutoCell(value: expense.cost),
      },
    );
  }

  Widget buildOutDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: KeepAlive(
          keepAlive: true,
          child: StreamBuilder(
              stream: _expenses,
              builder: (context, snapshot) {
                return PlutoGrid(
                    key: ValueKey('expense'),
                    columns: outColumns,
                    rows: snapshot.data!.map((e) => buildOutRow(e)).toList(),
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
