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

class _TraineesPageState extends State<TraineesPage>
    with AutomaticKeepAliveClientMixin {
  TraineeViewMore? traineeProfileWidget;

  late List<Trainee> trainees;

  @override
  void initState() {
    // TODO: implement initState
    trainees = Seeds.trainees;

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(Trainee trainee) {
    setState(() => traineeProfileWidget =
        TraineeViewMore(trainee: trainee, key: ValueKey<Trainee>(trainee)));
  }

  void closeProfile() {
    setState(() => traineeProfileWidget = null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [SizedBox(height: 25)],
                ),
              ),
              buildDataTable(),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.black,
          thickness: 0.1,
        ),
        traineeProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    traineeProfileWidget!,
                    Container(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: closeProfile,
                          icon: const Icon(Icons.close)),
                    ),
                  ],
                ),
              )
            : Container(),
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
        rows: trainees.map((e) => buildRow(e)).toList(),
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
          onListRowTap(trainee);
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       shape: const RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(30))),
          //       contentPadding: const EdgeInsets.all(0),
          //       content: SizedBox(
          //         width: MediaQuery.of(context).size.width * 0.6,
          //         // height: 498,
          //         child: Padding(
          //           padding: const EdgeInsets.only(bottom: 25),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               // CircleAvatar(
          //               //   radius: 80,
          //               // ),
          //               TraineeViewMore(trainee: trainee),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );
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
