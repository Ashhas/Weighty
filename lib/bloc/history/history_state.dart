part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryOpened extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  @override
  List<Object> get props => [];
}

class MonthChanged extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<MeasurementModel> allMeasurements;

  HistoryLoaded(this.allMeasurements);

  @override
  List<Object> get props => [];
}
