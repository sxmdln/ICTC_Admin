import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/Programs/card_button.dart';
import 'package:ictc_admin/pages/Trainers/trainers_forms.dart';

class TrainersPage extends StatefulWidget {
  TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
  List<Item> items = [
    Item(id: 1, name: 'Item 1', description: 'Description 1'),
    Item(id: 2, name: 'Item 2', description: 'Description 2'),
    Item(id: 3, name: 'Item 3', description: 'Description 3'),
  ];

// CRUD operations
  void addItem(Item item) {
    items.add(item);
  }

  void updateItem(Item newItem) {
    final index = items.indexWhere((item) => item.id == newItem.id);
    if (index != -1) {
      items[index] = newItem;
    }
  }

  void deleteItem(int id) {
    items.removeWhere((item) => item.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 1350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardButton(),
                CardButton(),
                CardButton(),
                CardButton(),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Card(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 72,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(26, 19, 26, 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              addButton()
                            ],
                          ),
                        )),
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
                          const DataCell(
                              Text('Intro to Cybersecurity')),
                          const DataCell(Text('')),
                          DataCell(Row(
                            children: [
                              editButton(),
                              const Padding(padding: EdgeInsets.all(5)),
                              // FilledButton(
                              //   style: ButtonStyle(
                              //     backgroundColor:
                              //         MaterialStateProperty.resolveWith(
                              //             (states) {
                              //       // If the button is pressed, return green, otherwise blue
                              //       if (states
                              //           .contains(MaterialState.pressed)) {
                              //         return Colors.red;
                              //       }
                              //       return Colors.red;
                              //     }),
                              //   ),
                              //   onPressed: () {},
                              //   child: const Icon(
                              //     Icons.delete,
                              //     color: Colors.white,
                              //   ),
                              // )
                            ],
                          )),
                        ]),
                      ],
                    ))
                  ],
                )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget addButton() {
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
                        child: TrainerForm(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text(
        "Add Trainee",
        style: TextStyle(
          color: Colors.white,
        ),
      )
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
                        child: TrainerForm(trainer: true,),
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
}

class Item {
  int id;
  String name;
  String description;

  Item({required this.id, required this.name, required this.description});
}
