import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
            BlocBuilder<AddWeightBloc, AddWeightState>(
              builder: (context, state) {
                if (state is AddWeightLoaded) {
                  return TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: kFocusedDay,
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    eventLoader: (day) {
                      List<DateTime> sortedList = [];
                      DateFormat formatter = DateFormat('yyyy-MM-dd');

                      if (state.allMeasurements != null) {
                        state.allMeasurements.forEach(
                          (element) {
                            if (formatter.format(day) ==
                                formatter.format(element.dateAdded)) {
                              sortedList.add(element.dateAdded);
                            }
                          },
                        );
                      }
                      return sortedList;
                    },
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      markerSize: 13.0,
                      markerDecoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      todayDecoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      weekendTextStyle: TextStyle(color: Colors.black),
                    ),
                    onDaySelected: _onDaySelected,
                    enabledDayPredicate: (day) {
                      if (day.isBefore(DateTime.now())) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
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
