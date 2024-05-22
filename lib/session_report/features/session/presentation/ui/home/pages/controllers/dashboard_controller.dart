import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dashboard_state.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  DashboardState build() {
    return DashboardState();
  }

  void toggleGroupByLocation() {
    debugPrint(
        "Toggle group by location: \n Current: ${state.groupByLocation} :::::: New: ${!state.groupByLocation}");
    state = state.copyWith(groupByLocation: !state.groupByLocation);
  }
}

// @riverpod
// GroupUsers groupByLocationUsers(GroupByLocationUsersRef ref) {
//   final groupByLocation = ref.watch(
//     dashboardControllerProvider.select((value) => value.groupByLocation),
//   );
//   debugPrint("Group by users filtered: $groupByLocation");
//   if (groupByLocation) {
//     final groupedUsers = groupBy(users, (user) => user.location);
//     final locations = groupedUsers.keys.toList();
//     final usersByLocation = groupedUsers.values.toList();
//     return GroupByLocationUsers(
//       locations: locations,
//       usersByLocation: usersByLocation,
//     );
//   } else {
//     return NonGroupUsers(users: users);
//   }
// }

