import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/report.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails(
      {super.key,
      required this.reports,
      required this.totalIncome,
      required this.totalExpenses,
      required this.netIncome});

  final double totalIncome, totalExpenses, netIncome;
  final List<Report> reports;

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff19306B),
      appBar: AppBar(
        title: const Text('Report Details'),
        backgroundColor: const Color(0xff19306B),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Text(
                  "Month: ${DateFormat.MMMM().format(widget.reports.first.orDate)} ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Income: P${widget.totalIncome} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "| Total Expense:P${widget.totalExpenses}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Net Income: P${widget.netIncome} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            color: const Color(0xfff1f5fb),
            child: DataTable2(
              bottomMargin: 90,
              isVerticalScrollBarVisible: true,
              minWidth: 600,
              horizontalMargin: 100,
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Program')),
                DataColumn(label: Text('Course')),
                DataColumn(label: Text('In')),
                DataColumn(label: Text('Out')),
                DataColumn(label: Text('Balance')),
              ],
              rows: [], 
              // rows: widget.report.students?.isNotEmpty == true
              //     ? widget.report.students!
              //         .map((student) => buildRow(student))
              //         .toList()
              //     : [],
            ),
          ),
        ),
      ],
    );
  }

  DataRow2 buildRow(student) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(
        student.name,
      )),
      DataCell(Text(student.status)),
    ]);
  }
}
