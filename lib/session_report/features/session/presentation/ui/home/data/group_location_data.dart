import '../pages/dashboard/widgets/expandable_data_table.dart';
import 'user.dart';

sealed class GroupUsers {}

class NonGroupUsers extends GroupUsers {
  final List<User> users;

  NonGroupUsers({required this.users});
}

class GroupByLocationUsers extends GroupUsers {
  final List<Location> locations;

  GroupByLocationUsers({
    required this.locations,
  });
}
