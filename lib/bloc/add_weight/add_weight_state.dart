part of 'add_weight_bloc.dart';

@immutable
abstract class AddWeightState extends Equatable {
  const AddWeightState();

  @override
  List<Object> get props => [];
}

class AddWeightOpened extends AddWeightState {
  @override
  List<Object> get props => [];
}

class AddWeightLoading extends AddWeightState {
  @override
  List<Object> get props => [];
}

class AddWeightLoaded extends AddWeightState {
  final List<MeasurementModel> allMeasurements;

  AddWeightLoaded(this.allMeasurements);

  @override
  List<Object> get props => [];
}

class NewMeasurementAdded extends AddWeightState {
  @override
  List<Object> get props => [];
}
