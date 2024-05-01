import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/finance.dart';
import 'package:ictc_admin/models/sale.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/finance/forms/expenses_form.dart';
import 'package:ictc_admin/pages/finance/tables/expense.dart';
import 'package:ictc_admin/pages/finance/tables/finance.dart';
import 'package:ictc_admin/pages/finance/tables/income.dart';
import 'package:ictc_admin/pages/finance/forms/sales_form.dart';
import 'package:pluto_grid/pluto_grid.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage>
    with AutomaticKeepAliveClientMixin {
  bool shouldKeepAlive = true;
  @override
  bool get wantKeepAlive => true;

  late Stream<List<Finance>> _finances;
  late Stream<List<Income>> _incomes;
  late Stream<List<Expense>> _expenses;

  @override
  void initState() {
    _finances = Seeds.financeStream();
    _incomes = Seeds.incomeStream();
    _expenses = Seeds.expenseStream();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xfff1f5fb),
          appBar: AppBar(
            backgroundColor: const Color(0xfff1f5fb),
            title: const TabBar(
              overlayColor: MaterialStatePropertyAll(Color(0xfff1f5fb)),
              tabs: [
                Tab(text: 'Finance'),
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
            ),
          ),
          body: const Column(
            children: [
              Expanded(
                flex: 1,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  viewportFraction: 0.9,
                  children: [
                    FinanceTable(),
                    IncomeTable(),
                    ExpenseTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// new BUTTONS

  Widget addButtonAnim() {
    return AnimatedContainer(
      height: 40,
      width: 155,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: const Color.fromARGB(255, 57, 167, 74),
        borderRadius: BorderRadius.circular(25.0),
        child: InkWell(
          splashColor: Colors.blue,
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return addSaleDialog();
              },
            );
          },
        ),
      ),
    );
  }

  //BUTTONS
  Widget editSaleButton() {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editSaleDialog();
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

  Widget editSaleDialog() {
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
            "Edit a Sale",
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
          height: MediaQuery.of(context).size.height * 0.4,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SalesForm(sale: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addSaleButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              const MaterialStatePropertyAll(Color.fromARGB(255, 57, 167, 74)),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          fixedSize: MaterialStateProperty.all(
            const Size.fromWidth(155),
          )),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return addSaleDialog();
          },
        );
      },
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: 120, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Row(children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          Text(
            'Add Income',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget addSaleDialog() {
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
            "Add Income",
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
          height: MediaQuery.of(context).size.height * 0.6,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SalesForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // BUTTONS (Expenses)

  Widget editExpenseButton() {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editExpenseDialog();
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

  Widget editExpenseDialog() {
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
          height: MediaQuery.of(context).size.height * 0.3,
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

  Widget addExpenseButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              const MaterialStatePropertyAll(Color.fromARGB(255, 57, 167, 74)),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          fixedSize: MaterialStateProperty.all(
            const Size.fromWidth(160),
          )),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return addExpenseDialog();
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

  Widget addExpenseDialog() {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
          height: MediaQuery.of(context).size.height * 0.3,
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