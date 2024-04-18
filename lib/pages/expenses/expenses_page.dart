import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/expenses/expenses_form.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late Stream<List<Expense>> _expenses;

  @override
  void initState() {
    // TODO: implement initState for populating the table with data from the backend
    // Currently a placeholder -- Aaron
    _expenses = Seeds.expenseStream();

    super.initState();
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
                padding: const EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addButton(),
                  ],
                ),
              ),
              buildDataTable(),
            ],
          ),
        ),
      ],
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
                  'Type of Expense',
                )),
                DataColumn2(
                    label: Text(
                  'Date',
                )),
                DataColumn2(
                    label: Text(
                  'Total Cost',
                )),
                DataColumn2(
                    label: Text(
                  'Actions',
                )),
              ],
              rows: snapshot.data!.map((e) => buildRow(e)).toList(),
            ),
          );
        });
  }

  DataRow2 buildRow(Expense expense) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(expense.name)),
      DataCell(Text(expense.date)),
      DataCell(Text(expense.cost.toString())),
      DataCell(
        editButton(),
      ),
    ]);
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
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Edit an Expense",
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
          width: 380,
          height: MediaQuery.of(context).size.height * 0.2,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ExpensesForm(expense: true),
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
          SizedBox(width: 6),
          Text(
            'Add Expense',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget addDialog() {
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
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Add an Expense",
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
          width: 380,
          height: MediaQuery.of(context).size.height * 0.2,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ExpensesForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
