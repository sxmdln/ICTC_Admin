import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/Trainers/trainers_forms.dart';
import 'package:ictc_admin/pages/Trainers/trainers_viewMore.dart';

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
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.8,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              trainersCounter(),
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
                              viewMore()
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
            title: Text(
              "Add Trainer",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w300
              ),
            ),
            content: SizedBox(
              width: 800,
              child: Padding(
                padding: EdgeInsets.fromLTRB(27, 0, 27, 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(),
                    Padding(padding: EdgeInsets.all(10)),
                    TrainerForm(),
                  ],
                ),
              ),
            )
          );
        },
      );
    },
    child: const Row(
      children: [
        Icon(
          Icons.add,
          color: Colors.white,
        ),
        SizedBox(width: 5),
        Text(
          'Add Trainer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
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
                width: 800,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                        // TODO: Pass Program object to form
                      TrainerForm(trainer: true,),
                      
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

  Widget viewMore(){
    return FilledButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: SizedBox(
                width: 600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(27, 25, 27, 25),
                  child: TrainerViewMore()
                ),
              ),
            );
          }
        );
      }, 
      child: const Icon(
        Icons.remove_red_eye,
        color: Colors.white,
      )
    );
  }

  Widget trainersCounter(){
    return const Row(
      children: [
        Text('Total Trainers: '),
        
        //TODO: sa baba neto is yung code sa counter ng total course
        Text('1')
      ],
    );
  }
}

class Item {
  int id;
  String name;
  String description;

  Item({required this.id, required this.name, required this.description});
}
