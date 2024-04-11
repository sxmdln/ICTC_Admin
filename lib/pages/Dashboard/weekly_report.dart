import 'package:flutter/cupertino.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({super.key});

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
            Text("(March 4 - 10, 2024)")
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
        buildDay1(),
        buildDay2(),
        buildDay3(),
        buildDay4(),
        buildDay5(),
        buildDay6(),
        buildDay7(),
        const SizedBox(
          height: 30,
        ), 
        buildTotalRow(),
      ],
    );
  }

  Row buildDay1() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 4")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay2() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 5")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay3() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 6")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay4() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 7")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay5() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 8")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay6() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 9")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildDay7() {
    return const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [Text("March 10")],
      ),
      Column(
        children: [Text("2,000")],
      ),
      Column(
        children: [Text("1,000")],
      ),
      Column(
        children: [Text("1,000")],
      )
    ]);
  }

  Row buildTotalRow() {
    return const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        
        children: [Text("7,000", style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),SizedBox(
          width: 280,
        ), ],
      ),
    ]);
  }
}
