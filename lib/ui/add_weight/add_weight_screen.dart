import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/add_weight/widgets/add_weight_dialog.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/constants/variable_const.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen() : super();

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  List<MeasurementModel> allMeasurements = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddWeightBloc>(context).add(AddWeightStarted());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: kFocusedDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.black),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                weekendTextStyle: TextStyle(color: Colors.black),
              ),
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: Column(
        children: [
          Text(
            UiConst.addWeightTitle,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            UiConst.addWeightLabel,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )
        ],
      ),
      centerTitle: true,
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddWeightDialog(selectedDay: selectedDay);
      },
    );
  }
}
