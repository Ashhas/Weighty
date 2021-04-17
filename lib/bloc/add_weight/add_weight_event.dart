part of 'add_weight_bloc.dart';

@immutable
abstract class AddWeightEvent extends Equatable {
  const AddWeightEvent();

  @override
  List<Object> get props => [];
}

class AddWeightStarted extends AddWeightEvent {
  @override
  List<Object> get props => [];
}

class AddNewMeasurement extends AddWeightEvent {
  final DateTime selectedDate;
  final String measurementInput;

  AddNewMeasurement(this.selectedDate, this.measurementInput);

  @override
  List<Object> get props => [];
}
