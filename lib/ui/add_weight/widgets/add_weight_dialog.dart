import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/bloc/add_weight/date_button/date_button_bloc.dart';
import 'package:weighty/util/common_functions.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/constants/variable_const.dart';

class AddWeightDialog extends StatefulWidget {
  const AddWeightDialog() : super();

  @override
  _AddWeightDialogState createState() => _AddWeightDialogState();
}

class _AddWeightDialogState extends State<AddWeightDialog> {
  TextEditingController textFormController;

  @override
  void initState() {
    textFormController = TextEditingController();
  }

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: kFocusedDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: Theme.of(context).primaryTextTheme.bodyText1,
                weekendStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                markerSize: 13.0,
                markerDecoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                todayDecoration:
                    BoxDecoration(color: Theme.of(context).accentColor),
                defaultTextStyle: Theme.of(context).primaryTextTheme.bodyText1,
                weekendTextStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              onDaySelected: _onDaySelected,
              enabledDayPredicate: (day) {
                if (DateTime.now().isAfter(day) ||
                    CommonFunctions.isToday(day)) {
                  return true;
                } else {
                  return false;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    BlocProvider.of<DateButtonBloc>(context).add(ChangeDate(selectedDay));
    //Close Dialog
    Navigator.of(context).pop();
  }
}
