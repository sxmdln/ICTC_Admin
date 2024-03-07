import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/pages/trainees/trainees_viewMore.dart';

class TraineesPage extends StatefulWidget {
  const TraineesPage({super.key});

  @override
  State<TraineesPage> createState() => _TraineesPageState();
}

class _TraineesPageState extends State<TraineesPage> {
  late List<Trainee> trainees;

  @override
  void initState() {
    // TODO: implement initState
    trainees = Seeds.trainees;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          padding: const EdgeInsets.only(
            right: 5,
          ),
        ),
        buildDataTable(),
      ],
    );
  }

  Widget buildDataTable() {
    return Expanded(
      child: DataTable2(
        showCheckboxColumn: false,
        showBottomBorder: true,
        horizontalMargin: 30,
        isVerticalScrollBarVisible: true,
        columns: const [
          DataColumn2(label: Text('Name')),
          // DataColumn2(label: Text('Attended Programs')),
          DataColumn2(label: Text('')),
          DataColumn2(label: Text('Option')),
        ],
        rows:  trainees.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  DataRow2 buildRow(Trainee trainee) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(trainee.toString())),
      // const DataCell(Text('Advance Figma')),
      const DataCell(Text('')),
      DataCell(Row(
        children: [viewButton(trainee)],
      )),
    ]);
  }

  Widget viewButton(Trainee trainee) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                contentPadding: const EdgeInsets.all(0),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                  // height: 498,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 80,
                        // ),
                        TraineeViewMore(trainee: trainee),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
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
        ));
  }
}
