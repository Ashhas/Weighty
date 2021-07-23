part of 'weight_unit_bloc.dart';

@immutable
abstract class WeightUnitState extends Equatable {
  const WeightUnitState();

  @override
  List<Object> get props => [];
}

class WeightUnitsOpened extends WeightUnitState {
  @override
  List<Object> get props => [];
}

class WeightUnitsUpdated extends WeightUnitState {
  @override
  List<Object> get props => [];
}

class WeightUnitsLoaded extends WeightUnitState {
  final String weightUnit;

  WeightUnitsLoaded({this.weightUnit});

  @override
  List<Object> get props => [];
}
