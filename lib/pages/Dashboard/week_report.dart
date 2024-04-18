import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/sale.dart';
import 'package:ictc_admin/models/seeds.dart';

class WeekReport extends StatefulWidget {
  const WeekReport({super.key});

  @override
  State<WeekReport> createState() => _WeekReportState();
}

class _WeekReportState extends State<WeekReport> {
  late Stream<List<Expense>> _expenses;
  late Stream<List<Sale>> _sales;

  @override
  void initState() {
    // TODO: implement initState for populating the table with data from the backend
    // Currently a placeholder -- Aaron
    _expenses = Seeds.expenseStream();
    _sales = Seeds.saleStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildDataTable());
  }

  Widget buildTable(BuildContext context) {
    const TextStyle headertextStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    const TextStyle rowtextStyle = TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );

    const Color headerColor = Color.fromARGB(255, 103, 131, 203);
    const Color rowColor = Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // row 1 forda week report
            color: headerColor,
            height: 45,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Weekday",
                  style: headertextStyle,
                ),
                Text("Expense Name", style: headertextStyle),
                Text("Paid to", style: headertextStyle),
                Text("Amount Paid", style: headertextStyle),
              ],
            ),
          ),
          Container(
            // row 2 forda week report
            color: rowColor,
            height: 45,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 85),
                Text(
                  "Monday",
                  style: rowtextStyle,
                ),
                SizedBox(
                  width: 110,
                ),
                Text("Snacks", style: rowtextStyle),
                SizedBox(
                  width: 80,
                ),
                Text("Microcredentials", style: rowtextStyle),
                SizedBox(
                  width: 80,
                ),
                Text("500", style: rowtextStyle),
                SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataTable() {
    return StreamBuilder(
        stream: _expenses,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Expanded(
            child: DataTable2(
              showCheckboxColumn: false,
              showBottomBorder: true,
              horizontalMargin: 30,
              isVerticalScrollBarVisible: true,
              columns: const [
                DataColumn2(
                    label: Text(
                  'Weekdate',
                )),
                DataColumn2(
                    label: Text(
                  'Acquired Sales',
                )),
                DataColumn2(
                    label: Text(
                  'Expenses Paid',
                )),
                DataColumn2(
                    label: Text(
                  'Subtotal',
                )),
              ],
              rows: snapshot.data!.map((e) => buildRow(e)).toList(),
            ),
          );
        });
  }

  DataRow2 buildRow(Expense expense) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(expense.date)),
      DataCell(Text("1000")),
      DataCell(Text("450")),
      DataCell(Text("550")),
    ]);
  }
}
