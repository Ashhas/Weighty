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
