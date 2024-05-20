import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/pages/trainees/trainees_viewMore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TraineesPage extends StatefulWidget {
  const TraineesPage({super.key});

  @override
  State<TraineesPage> createState() => _TraineesPageState();
}

class _TraineesPageState extends State<TraineesPage>
    with AutomaticKeepAliveClientMixin {
  TraineeViewMore? traineeProfileWidget;

  late Stream<List<Trainee>> _trainees;
  late List<Trainee> _allTrainees;
  late List<Trainee> _filteredTrainees;
  String _searchQuery = "";

  @override
  void initState() {
    _trainees = Supabase.instance.client
        .from('student')
        .stream(primaryKey: ['id']).map((data) {
      final trainees = data.map((e) => Trainee.fromJson(e)).toList();
      _allTrainees = trainees;
      _filteredTrainees = trainees;
      return trainees;
    });
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

  void _filterTrainees(String query) {
    final filtered = _allTrainees.where((trainee) {
      final firstNameLower = trainee.firstName.toLowerCase();
      final lastNameLower = trainee.lastName.toLowerCase();
      final searchLower = query.toLowerCase();
      return firstNameLower.contains(searchLower) ||
          lastNameLower.contains(searchLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredTrainees = filtered;
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
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildSearchBar(),
                  ],
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
        traineeProfileWidget != null
            ? Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    traineeProfileWidget!,
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
            hintText: "Search a Trainee...",
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
          onChanged: (query) => _filterTrainees(query),
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return StreamBuilder(
        stream: _trainees,
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
              sortAscending: false,empty: Column(
                children: [
                  Icon(CupertinoIcons.question_circle, size: 50, color: Colors.grey),
                  Text('Add a trainees to get started!'),
                ],
              ),
              showBottomBorder: true,
              horizontalMargin: 30,
              isVerticalScrollBarVisible: true,
              columns: const [
                DataColumn2(label: Text('Name')),
                // DataColumn2(label: Text('Attended Trainees')),
                DataColumn2(label: Text('')),
                DataColumn2(label: Text('Option')),
              ],
              // rows: snapshot.data!.map((e) => buildRow(e)).toList(),
              rows: _filteredTrainees
                  .map((trainee) => buildRow(trainee))
                  .toList(),
            ),
          );
        });
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
