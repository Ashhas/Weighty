part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryStarted extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class NavigateToPreviousMonth extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class NavigateToNextMonth extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class EditMeasurement extends HistoryEvent {
  final MeasurementModel measurementModel;
  final String updatedWeight;

  EditMeasurement(this.measurementModel, this.updatedWeight);

  @override
  List<Object> get props => [];
}

class DeleteMeasurement extends HistoryEvent {
  final MeasurementModel measurementModel;

  DeleteMeasurement(this.measurementModel);

  @override
  List<Object> get props => [];
}
