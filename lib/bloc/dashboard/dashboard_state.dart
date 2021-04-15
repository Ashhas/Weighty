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
  final String username;
  final double startWeight;
  final String startWeightDate;
  final double targetWeight;
  final String targetWeightDate;
  final double percentageDone;

  DashboardLoaded(
      this.measurement,
      this.username,
      this.startWeight,
      this.startWeightDate,
      this.targetWeight,
      this.targetWeightDate,
      this.percentageDone)
      : assert(measurement != null);

  @override
  List<Object> get props => [];
}
