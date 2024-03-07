import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:ictc_admin/pages/trainers/trainers_forms.dart';
import 'package:ictc_admin/pages/trainers/trainers_viewMore.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
// // CRUD operations
//   void addItem(Item item) {
//     items.add(item);
//   }
//   void updateItem(Item newItem) {
//     final index = items.indexWhere((item) => item.id == newItem.id);
//     if (index != -1) {
//       items[index] = newItem;
//     }
//   }
//   void deleteItem(int id) {
//     items.removeWhere((item) => item.id == id);
//   }
  late List<Trainer> trainers;

  @override
  void initState() {
    // TODO: implement initState for populating the table with data from the backend
    trainers = Seeds.trainers;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          padding: const EdgeInsets.only(right: 5, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [addButton()],
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
          DataColumn2(
              label: Text(
            'Name of Trainer',
          )),
          DataColumn2(
              label: Text(
            'Actions',
          )),
        ],
        rows: trainers.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  DataRow2 buildRow(Trainer trainer) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(trainer.toString())),
      DataCell(Row(
        children: [
          editButton(),
          viewButton(trainer),
        ],
      )),
    ]);
  }

  Widget addButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TrainersForm(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        constraints: const BoxConstraints(
            minWidth: 160, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Row(children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          Text(
            'Add a Trainer',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget editButton() {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TrainersForm(
                            trainer: true,
                          ),
                        ],
                      ),
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

  Widget viewButton(Trainer trainer) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                contentPadding: const EdgeInsets.all(0),
                content: SizedBox(
                  width: 600,
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
                        TrainerViewMore(trainer: trainer),
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
