import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/util/constants/variable_const.dart';

part 'date_button_event.dart';

part 'date_button_state.dart';

class DateButtonBloc extends Bloc<DateButtonEvent, DateButtonState> {
  DateButtonBloc() : super(DateButtonInit());

  @override
  Stream<DateButtonState> mapEventToState(DateButtonEvent event) async* {
    if (event is LoadFirstDate) {
      yield* _mapLoadFirstDateToState();
    } else if (event is ChangeDate) {
      yield* _mapSelectDateToState(event.selectedDate);
    }
  }

  Stream<DateButtonState> _mapLoadFirstDateToState() async* {
    yield ShowChosenDate(chosenDate: kToday);
  }

  Stream<DateButtonState> _mapSelectDateToState(DateTime date) async* {
    yield DateChanged();

    yield ShowChosenDate(chosenDate: date);
  }
}
