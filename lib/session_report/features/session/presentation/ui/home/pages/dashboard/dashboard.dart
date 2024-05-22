import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/group_location_data.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/expandable_data_table.dart';
import 'widgets/general_data_table.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              GroupByLocationToggle(),
              Expanded(
                child: UsersDataTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsersDataTable extends ConsumerWidget {
  const UsersDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupUsers = ref.watch(groupByLocationUsersProvider);
    debugPrint("Users Data table build: ");
    switch (groupUsers) {
      case NonGroupUsers():
        return GeneralDataTable(users: groupUsers.users);
      case GroupByLocationUsers():
        return ExpandableDataTable(groupUsers: groupUsers);
    }
  }
}

class GroupByLocationToggle extends ConsumerWidget {
  const GroupByLocationToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupByLocation = ref.watch(
      dashboardControllerProvider.select((value) => value.groupByLocation),
    );
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.all(0),
      value: groupByLocation,
      onChanged: (value) {
        ref.read(dashboardControllerProvider.notifier).toggleGroupByLocation();
      },
      title: const Text('Group By Location'),
    );
  }
}
