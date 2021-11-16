part of 'date_button_bloc.dart';

@immutable
abstract class DateButtonState extends Equatable {
  const DateButtonState();

  @override
  List<Object> get props => [];
}
class DateButtonInit extends DateButtonState {
  @override
  List<Object> get props => [];
}

class DateChanged extends DateButtonState {
  @override
  List<Object> get props => [];
}

class ShowChosenDate extends DateButtonState {
  final DateTime chosenDate;

  ShowChosenDate({this.chosenDate});

  @override
  List<Object> get props => [];
}
