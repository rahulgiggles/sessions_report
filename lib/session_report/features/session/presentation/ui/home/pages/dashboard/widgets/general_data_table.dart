import 'package:flutter/material.dart';

import '../../../data/user.dart';

class GeneralDataTable extends StatelessWidget {
  final List<User> users;
  const GeneralDataTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [
      const DataColumn(label: Text('Name')),
      const DataColumn(label: Text('Age')),
      const DataColumn(label: Text('Email')),
      const DataColumn(label: Text('Phone')),
      const DataColumn(label: Text('Location')),
      const DataColumn(label: Text('Action')),
    ];

    List<DataRow> rows = users.map((user) {
      return DataRow(
        cells: [
          DataCell(Text(user.name)),
          DataCell(Text(user.age.toString())),
          DataCell(Text(user.email)),
          DataCell(Text(user.phone)),
          DataCell(Text(user.location)),
          DataCell(
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ),
        ],
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: DataTable(
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }
}
