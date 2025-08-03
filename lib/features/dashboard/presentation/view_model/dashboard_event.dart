import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to trigger fetching and loading dashboard data.
class LoadDashboardData extends DashboardEvent {}


