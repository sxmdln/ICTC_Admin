import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/Trainers/trainers_forms.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // const Padding(padding: EdgeInsets.all(20)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildDataTable(),
          ],
        )
      ],
    );
  }


  Widget buildDataTable() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                trainersCounter(),
                addButton()
              ],
            ),
          ),
          Expanded(
              child: DataTable2(
            horizontalMargin: 12,
            columns: const [
              DataColumn2(label: Text('Name')),
              DataColumn2(label: Text('Handled Courses')),
              DataColumn2(label: Text('')),
              DataColumn2(label: Text('Option')),
            ],
            rows: [
              DataRow2(cells: [
                const DataCell(Text('Bananakin Skywalker')),
                const DataCell(Text('Intro to Cybersecurity')),
                const DataCell(Text('')),
                DataCell(Row(
                  children: [
                    editButton(),
                    const Padding(padding: EdgeInsets.all(5)),
                  ],
                )),
              ]),
            ],
          ))
        ],
      )),
    );
  }
      


  Widget addButton() {
    return IconButton(
          icon: const Icon(
            Icons.add,
            color: Color(0xff153faa),
          ),
          splashRadius: 25,
          tooltip: "add trainer",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Padding(
                    padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                        ),
                        SizedBox(height: 20),
                        TrainerForm(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
  }

  Widget editButton() {
    return FilledButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SizedBox(
                width: 406,
                height: 498,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        // TODO: Pass Program object to form
                        child: TrainerForm(
                          trainer: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  Widget trainersCounter() {
    return const Row(
      children: [
        Text('Total Trainers: '),
        //TODO: sa baba neto is yung code sa counter ng total course
        Text('1')
      ],
    );
  }
}
