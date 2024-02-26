import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/pages/Programs/card_button.dart';
import 'package:ictc_admin/pages/Trainees/trainee_forms.dart';

class TraineesPage extends StatefulWidget {
  const TraineesPage({super.key});

  @override
  State<TraineesPage> createState() => _TraineesPageState();
}

class _TraineesPageState extends State<TraineesPage> {
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
                              addButton(),
                            ],
                          ),
                        )),
                    Expanded(
                        child: DataTable2(
                      horizontalMargin: 12,
                      columns: const [
                        DataColumn2(label: Text('Name')),
                        DataColumn2(label: Text('Attended Programs')),
                        DataColumn2(label: Text('')),
                        DataColumn2(label: Text('Option')),
                      ],
                      rows: [
                        DataRow2(cells: [
                          const DataCell(Text('Taylor Batumbakal Swift')),
                          const DataCell(
                              Text('Advance Figma')),
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
                        child: TraineeForm(),
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
                        child: TraineeForm(trainee: true,),
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
