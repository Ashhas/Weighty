part of 'weight_unit_bloc.dart';

@immutable
abstract class WeightUnitEvent extends Equatable {
  const WeightUnitEvent();

  @override
  List<Object> get props => [];
}

class WeightUnitStarted extends WeightUnitEvent {
  @override
  List<Object> get props => [];
}

class ChangeWeightUnit extends WeightUnitEvent {
  final String weightUnit;

  ChangeWeightUnit({this.weightUnit});

  @override
  List<Object> get props => [];
}
