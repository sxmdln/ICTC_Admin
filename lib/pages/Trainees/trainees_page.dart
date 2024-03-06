import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/trainees/trainees_viewMore.dart';

class TraineesPage extends StatefulWidget {
  const TraineesPage({super.key});

  @override
  State<TraineesPage> createState() => _TraineesPageState();
}

class _TraineesPageState extends State<TraineesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          padding: EdgeInsets.only(
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
        rows: [
          DataRow2(onSelectChanged: (selected) {}, cells: [
            const DataCell(Text('Taylor Batumbakal Swift')),
            // const DataCell(Text('Advance Figma')),
            const DataCell(Text('')),
            DataCell(Row(
              children: [viewButton()],
            )),
          ]),
        ],
      ),
    );
  }

  Widget viewButton() {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: SizedBox(
                  width: 600,
                  // height: 498,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 80,
                        // ),
                        TraineeViewMore(),
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
            Text("View", style: TextStyle(color: Colors.black54,),),
          ],
        ));
  }
}
