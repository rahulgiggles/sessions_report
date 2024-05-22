import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/data_provider.dart';
import '../data/group_location_data.dart';
import '../pages/controllers/dashboard_controller.dart';
import '../pages/dashboard/widgets/expandable_data_table.dart';

part 'providers.g.dart';

@riverpod
Location location(LocationRef ref) {
  throw UnimplementedError();
}

final locationViaProvider = StateProvider<Location>((ref) {
  throw UnimplementedError();
});

final groupByLocationUsersProvider =
    StateProvider.autoDispose<GroupUsers>((ref) {
  final groupByLocation = ref.watch(
    dashboardControllerProvider.select((value) => value.groupByLocation),
  );
  debugPrint("Group by users filtered: $groupByLocation");
  if (groupByLocation) {
    final groupedUsers = groupBy(users, (user) => user.location);
    final locations = groupedUsers.keys.toList();
    final usersByLocation = groupedUsers.values.toList();
    return GroupByLocationUsers(
      locations: locations
          .asMap()
          .entries
          .map(
            (entry) => Location(
                name: entry.value,
                expanded: true,
                users: usersByLocation[entry.key]),
          )
          .toList(),
    );
  } else {
    return NonGroupUsers(users: users);
  }
});
