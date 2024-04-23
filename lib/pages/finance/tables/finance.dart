import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/finance.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:pluto_grid/pluto_grid.dart';

class FinanceTable extends StatefulWidget {
  const FinanceTable({super.key});

  @override
  State<FinanceTable> createState() => _FinanceTableState();
}

class _FinanceTableState extends State<FinanceTable> {
  late Stream<List<Finance>> _finances;
  @override
  void initState() {
    _finances = Seeds.financeStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildFinanceDataTable();
  }

  // FIN (Finance)
  List<PlutoColumn> financeColumns = [
    PlutoColumn(
      title: 'ID',
      field: 'id',
      readOnly: true,
      type: PlutoColumnType.number(),
      minWidth: 50,
      width: 90,
      enableDropToResize: false,
    ),
    PlutoColumn(
      title: 'Date',
      field: 'date',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Detail',
      field: 'detail',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Program',
      field: 'program',
      readOnly: true,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Price',
      field: 'price',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Quantity',
      field: 'quantity',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Total',
      field: 'total',
      readOnly: true,
      type: PlutoColumnType.number(),
    ),
  ];

  PlutoRow buildFinanceRow(Finance finance) {
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: finance.id),
        'date': PlutoCell(value: finance.date),
        'detail': PlutoCell(value: finance.detail),
        'program': PlutoCell(value: finance.program),
        'price': PlutoCell(value: finance.price),
        'quantity': PlutoCell(value: finance.quantity),
        'total': PlutoCell(value: finance.total),
      },
    );
  }

  Widget buildFinanceDataTable() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
            stream: _finances,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return PlutoGrid(
                  columns: financeColumns,
                  rows: snapshot.data!.map((e) => buildFinanceRow(e)).toList(),
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
