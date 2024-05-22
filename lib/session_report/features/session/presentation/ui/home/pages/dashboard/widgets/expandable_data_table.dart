import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../data/group_location_data.dart';
import '../../../data/user.dart';

class ExpandableDataTable extends StatelessWidget {
  final GroupByLocationUsers groupUsers;
  const ExpandableDataTable({super.key, required this.groupUsers});

  @override
  Widget build(BuildContext context) {
    final _columns = [
      'Name',
      'Age',
      'Email',
      'Phone',
      'Location',
      'Action',
    ];
    Widget buildData() {
      return Column(
        children: [
          Row(
            children: _columns
                .map(
                  (e) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final location = groupUsers.locations[index];
                return ProviderScope(
                  overrides: [
                    locationProvider.overrideWithValue(location),
                  ],
                  child: const ExpansionUsersByLocationTile(),
                );
              },
              itemCount: groupUsers.locations.length,
            ),
          ),
        ],
      );
    }

    return buildData();
  }
}

class ExpansionUsersByLocationTile extends ConsumerStatefulWidget {
  const ExpansionUsersByLocationTile({super.key});

  @override
  ConsumerState<ExpansionUsersByLocationTile> createState() =>
      _ExpansionUsersByLocationTileState();
}

class _ExpansionUsersByLocationTileState
    extends ConsumerState<ExpansionUsersByLocationTile> {
  late Location _location;

  @override
  void initState() {
    super.initState();
    _location = ref.read(locationProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(
          title: _location.name,
          expanded: _location.expanded,
          onTap: () {
            _location = _location.copyWith(expanded: !_location.expanded);
            setState(() {});
          },
        ),
        const SizedBox(height: 8),
        if (_location.expanded)
          ..._location.users.map(
            (user) => Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  children: [
                    CustomTableCell(
                      child: Text(user.name),
                    ),
                    CustomTableCell(
                      child: Text(
                        user.age.toString(),
                      ),
                    ),
                    CustomTableCell(
                      child: Text(user.email),
                    ),
                    CustomTableCell(
                      child: Text(user.phone),
                    ),
                    CustomTableCell(
                      child: Text(user.location),
                    ),
                    CustomTableCell(
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 16,
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_rounded),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ],
    );
  }
}

class HeaderTitle extends StatefulWidget {
  final String title;
  final bool expanded;
  final VoidCallback onTap;
  const HeaderTitle({
    super.key,
    required this.title,
    required this.expanded,
    required this.onTap,
  });

  @override
  State<HeaderTitle> createState() => _HeaderTitleState();
}

class _HeaderTitleState extends State<HeaderTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0.5, // Rotate 90 degrees (pi/2 radians)
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    if (widget.expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleRotation,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: [
            RotationTransition(
              turns: _animation,
              child: const Icon(
                Icons.arrow_downward_rounded,
                size: 16,
              ),
            ),
            // const Icon(Icons.arrow_downward_rounded),
            const SizedBox(width: 16),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  final double? height;
  final Widget child;
  const CustomTableCell({
    super.key,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}

class Location {
  final String name;
  final bool expanded;
  final List<User> users;

  Location({
    required this.name,
    this.expanded = false,
    required this.users,
  });

  Location copyWith({
    String? name,
    bool? expanded,
    List<User>? users,
  }) {
    return Location(
      name: name ?? this.name,
      expanded: expanded ?? this.expanded,
      users: users ?? this.users,
    );
  }
}
