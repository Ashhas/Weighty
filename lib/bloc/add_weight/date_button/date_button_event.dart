part of 'date_button_bloc.dart';

@immutable
abstract class DateButtonEvent extends Equatable {
  const DateButtonEvent();

  @override
  List<Object> get props => [];
}

class LoadFirstDate extends DateButtonEvent {
  @override
  List<Object> get props => [];
}

class ChangeDate extends DateButtonEvent {
  final DateTime selectedDate;

  ChangeDate(this.selectedDate);

  @override
  List<Object> get props => [];
}
