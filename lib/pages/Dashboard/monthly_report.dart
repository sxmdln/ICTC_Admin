import 'package:flutter/cupertino.dart';

class MonthlyReport extends StatelessWidget {
  const MonthlyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sales and Expenses Report"),
            Text("(March 2024)")
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [Text("Date")],
          ),
          Column(
            children: [Text("Total Sales")],
          ),
          Column(
            children: [Text("Total Expenses")],
          ),
          Column(
            children: [Text("Total Income")],
          )
        ]),
        const SizedBox(
          height: 30,
        ), //TODO: LAGYAN NLNG DATA TABLE ETC
        buildWeek1(),
        buildWeek1(),
        buildWeek3(),
        buildWeek4(),
        const SizedBox(
          height: 30,
        ), 
        buildTotalRow(),
      ],
    );
  }

  Row buildWeek1() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("Week 1")],
      ),
      Column(
        children: [Text("14,000")],
      ),
      Column(
        children: [Text("7,000")],
      ),
      Column(
        children: [Text("7,000")],
      )
    ]);
  }
  Row buildWeek2() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("Week 2")],
      ),
      Column(
        children: [Text("14,000")],
      ),
      Column(
        children: [Text("7,000")],
      ),
      Column(
        children: [Text("7,000")],
      )
    ]);
  }
  Row buildWeek3() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("Week 3")],
      ),
      Column(
        children: [Text("14,000")],
      ),
      Column(
        children: [Text("7,000")],
      ),
      Column(
        children: [Text("7,000")],
      )
    ]);
  }
  Row buildWeek4() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("Week 4")],
      ),
      Column(
        children: [Text("14,000")],
      ),
      Column(
        children: [Text("7,000")],
      ),
      Column(
        children: [Text("7,000")],
      )
    ]);
  }

  Row buildTotalRow() {
    return const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        
        children: [Text("28,000", style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),SizedBox(
          width: 280,
        ), ],
      ),
    ]);
  }
}
