import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/pages/programs/program_forms.dart';
import 'package:ictc_admin/pages/programs/programs_viewMore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/pages/programs/program_forms.dart';
import 'package:ictc_admin/pages/programs/programs_viewMore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage>
    with AutomaticKeepAliveClientMixin {
  ProgramViewMore? programProfileWidget;
  late Stream<List<Program>> _programs;
  late List<Program> _allPrograms;
  late List<Program> _filteredPrograms;
  String _searchQuery = "";

  @override
  void initState() {
    _programs = Supabase.instance.client
        .from('program')
        .stream(primaryKey: ['id']).map((data) {
      final programs = data.map((e) => Program.fromJson(e)).toList();
      _allPrograms = programs;
      _filteredPrograms = programs;
      return programs;
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  onListRowTap(Program program) {
    setState(() => programProfileWidget =
        ProgramViewMore(program: program, key: ValueKey<Program>(program)));
  }

  void closeProfile() {
    setState(() => programProfileWidget = null);
  }

  void _filterPrograms(String query) {
    final filtered = _allPrograms.where((program) {
      final titleLower = program.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredPrograms = filtered;
    });
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
                padding: EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [buildSearchBar(), addButton()],
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
        programProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    programProfileWidget!,
                    Container(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: closeProfile,
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                ))
            : Container(),
      ],
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350,
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Search a Program...",
            hintStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 0,
                textBaseline: TextBaseline.alphabetic),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              size: 16,
            ),
            prefixIconColor: Colors.black,
          ),
          onChanged: (query) => _filterPrograms(query),
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return StreamBuilder(
        stream: _programs,
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
              sortAscending: false,
              empty: Column(
                children: [
                  Icon(CupertinoIcons.question_circle,
                      size: 50, color: Colors.grey),
                  Text('Add a program to get started!'),
                ],
              ),
              showBottomBorder: true,
              horizontalMargin: 30,
              isVerticalScrollBarVisible: true,
              columns: const [
                DataColumn2(label: Text('Title')),
                DataColumn2(label: Text('')),
                DataColumn2(label: Text('Option')),
              ],
              rows: _filteredPrograms
                  .map((program) => buildRow(program))
                  .toList(),
            ),
          );
        });
  }

  DataRow2 buildRow(Program program) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(program.title)),
      const DataCell(Text('')),
      DataCell(Row(
        children: [
          editButton(program),
          const Padding(padding: EdgeInsets.all(5)),
          viewButton(program)
        ],
      )),
    ]);
  }

  Widget addButton() {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(155))),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return addDialog();
          },
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 160, minHeight: 36.0),
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

  Widget addDialog() {
    return AlertDialog(
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
            "Add a Program",
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
          width: 400,
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
      ),
    );
  }

  Widget editButton(Program program) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog(program);
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

  Widget editDialog(Program program) {
    return AlertDialog(
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
            "Edit a Program",
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
          width: 400,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProgramForm(program: program),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewButton(Program program) {
    return TextButton(
        onPressed: () {
          onListRowTap(program);
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
