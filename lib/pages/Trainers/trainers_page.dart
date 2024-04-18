import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:ictc_admin/pages/trainers/trainers_forms.dart';
import 'package:ictc_admin/pages/trainers/trainers_viewMore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage>
    with AutomaticKeepAliveClientMixin {
  TrainerViewMore? trainerProfileWidget;
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
  late Stream<List<Trainer>> _trainers;

  @override
  void initState() {
    _trainers = Supabase.instance.client.from("trainer").stream(primaryKey: [
      'id'
    ]).map((data) => data.map((e) => Trainer.fromJson(e)).toList());

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  onListRowTap(Trainer trainer) {
    setState(() => trainerProfileWidget =
        TrainerViewMore(trainer: trainer, key: ValueKey<Trainer>(trainer)));
  }

  void closeProfile() {
    setState(() => trainerProfileWidget = null);
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
                  children: [addButton()],
                ),
              ),
              buildDataTable(),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.black87,
          thickness: 0.1,
        ),
        trainerProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    trainerProfileWidget!,
                    Container(
                      margin: const EdgeInsets.only(top: 45, right: 30),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 15,
                        onPressed: closeProfile,
                        icon: const Icon(Icons.close_outlined),
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buildDataTable() {
    return StreamBuilder(
        stream: _trainers,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

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
              rows: snapshot.data!.map((e) => buildRow(e)).toList(),
            ),
          );
        });
  }

  DataRow2 buildRow(Trainer trainer) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(trainer.toString())),
      DataCell(Row(
        children: [
          editButton(trainer),
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
            return addDialog();
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

  Widget addDialog() {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Add a Trainer",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 550,
          height: MediaQuery.of(context).size.height * 0.4,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
      ),
    );
  }

  Widget editButton(Trainer trainer) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog(trainer);
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

  Widget editDialog(Trainer trainer) {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Edit a Trainer",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 550,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TrainersForm(trainer: trainer),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewButton(Trainer trainer) {
    return TextButton(
        onPressed: () {
          onListRowTap(trainer);
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
