import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/seeds.dart';
import 'package:ictc_admin/pages/programs/program_forms.dart';
import 'package:ictc_admin/pages/programs/programs_viewMore.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  late List<Program> programs;

  @override
  void initState() {
    // TODO: implement initState
    programs = Seeds.programs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          padding: const EdgeInsets.only(right: 10, bottom: 8),
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
          DataColumn2(label: Text('Title')),
          DataColumn2(label: Text('')),
          DataColumn2(label: Text('Option')),
        ],
        rows: programs.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  DataRow2 buildRow(Program program) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(program.title)),
      const DataCell(Text('')),
      DataCell(Row(
        children: [
          editButton(),
          const Padding(padding: EdgeInsets.all(5)),
          viewButton(program)
        ],
      )),
    ]);
  }

  Widget addButton() {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size.fromWidth(155))),
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
                        ProgramForm(),
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
            maxWidth: 160, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child:
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          Text(
            'Add a Program',
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
                          ProgramForm(),
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

  Widget viewButton(Program program) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                content: ProgramViewMore(program: program),
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
