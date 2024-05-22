class DashboardState {
  final bool groupByLocation;

  DashboardState({this.groupByLocation = false});

  DashboardState copyWith({
    bool? groupByLocation,
  }) {
    return DashboardState(
      groupByLocation: groupByLocation ?? this.groupByLocation,
    );
  }
}
