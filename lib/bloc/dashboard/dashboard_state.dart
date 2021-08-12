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
  final double startWeight;
  final double targetWeight;
  final double percentageDone;
  final double totalLost;
  final double amountLeft;
  final String unitType;
  final List<MeasurementModel> filteredMeasurements;

  DashboardLoaded(
    this.measurement,
    this.startWeight,
    this.targetWeight,
    this.percentageDone,
    this.totalLost,
    this.amountLeft,
    this.unitType,
    this.filteredMeasurements,
  );

  @override
  List<Object> get props => [];
}
