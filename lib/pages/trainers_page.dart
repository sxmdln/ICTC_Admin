import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

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
    return Expanded(
      child: DataTable2(
        columns: const [
          DataColumn2(
            label: Text('ID'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Name'),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text('Description'),
            size: ColumnSize.L,
          ),
        ],
        rows: items
            .map((item) => DataRow(cells: [
                  DataCell(Text(item.id.toString())),
                  DataCell(Text(item.name)),
                  DataCell(Text(item.description)),
                ]))
            .toList(),
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
