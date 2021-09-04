part of 'goals_bloc.dart';

@immutable
abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object> get props => [];
}

class GoalsOpened extends GoalsState {
  @override
  List<Object> get props => [];
}

class GoalsLoading extends GoalsState {
  @override
  List<Object> get props => [];
}

class GoalsUpdated extends GoalsState {
  @override
  List<Object> get props => [];
}

class GoalsLoaded extends GoalsState {
  final String appVersion;
  final double startWeight;
  final String startWeightDate;
  final double targetWeight;
  final String targetWeightDate;

  GoalsLoaded(
      {this.appVersion,
      this.startWeight,
      this.startWeightDate,
      this.targetWeight,
      this.targetWeightDate});

  @override
  List<Object> get props => [];
}
