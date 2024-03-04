import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/trainers/trainers_forms.dart';

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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          padding: EdgeInsets.only(
            right: 5,
          ),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [addButton()],
            ),
          ),
        ),
        buildDataTable(),
      ],
    );
  }

  Widget buildDataTable() {
    return Expanded(
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.67,
        // width: MediaQuery.of(context).size.width * 0.8,
        // height: MediaQuery.of(context).size.height * 0.8,
        child: Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                    // DataColumn2(
                    //     label: Text(
                    //   'Handled Courses',
                    //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    // )),
                    // DataColumn2(label: Text('')),
                    DataColumn2(
                        label: Text(
                      'Actions',
                    )),
                  ],
                  rows: [
                    DataRow2(onSelectChanged: (selected) {}, cells: [
                      const DataCell(Text('John Doe')),
                      // const DataCell(Text('Intro to Cybersecurity')),
                      // const DataCell(Text('')),
                      DataCell(Row(
                        children: [
                          editButton(),
                          viewButton(),
                        ],
                      )),
                    ]),
                  ],
                ))
              ],
            )),
      ),
    );
  }

  Widget addButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                  ),
                  SizedBox(height: 20),
                  TrainersForm(),
                ],
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
            CupertinoIcons.person_add_solid,
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
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const Padding(
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
                          child: TrainersForm(
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

  Widget viewButton() {
    return TextButton(
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
                          child: TrainersForm(
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
