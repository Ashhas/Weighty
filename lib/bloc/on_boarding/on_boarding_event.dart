part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingEvent extends Equatable {}

class OnBoardingOpened extends OnBoardingEvent {
  @override
  List<Object> get props => [];
}

class AddedWeightUnit extends OnBoardingEvent {
  final String weightUnit;

  AddedWeightUnit({this.weightUnit});

  @override
  List<Object> get props => [];
}

class AddedWeightGoal extends OnBoardingEvent {
  final String targetWeight;

  AddedWeightGoal({this.targetWeight});

  @override
  List<Object> get props => [];
}

class AddedStartWeight extends OnBoardingEvent {
  final String startWeight;

  AddedStartWeight({this.startWeight});

  @override
  List<Object> get props => [];
}
