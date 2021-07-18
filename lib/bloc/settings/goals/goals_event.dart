part of 'goals_bloc.dart';

@immutable
abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class GoalsStarted extends GoalsEvent {
  @override
  List<Object> get props => [];
}

class ChangeStartWeight extends GoalsEvent {
  final String startWeight;

  ChangeStartWeight({this.startWeight});

  @override
  List<Object> get props => [];
}

class ChangeTargetWeight extends GoalsEvent {
  final String targetWeight;

  ChangeTargetWeight({this.targetWeight});

  @override
  List<Object> get props => [];
}
