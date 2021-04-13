part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardOpened extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoaded extends DashboardState {
  final MeasurementModel measurement;

  DashboardLoaded(this.measurement) : assert(measurement != null);

  @override
  List<Object> get props => [measurement];
}
