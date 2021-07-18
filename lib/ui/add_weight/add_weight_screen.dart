import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final textFormController = TextEditingController();
  List<MeasurementModel> allMeasurements = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddWeightBloc>(context).add(AddWeightStarted());
  }

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
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
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          Text(
            UiConst.addWeightLabel,
            style: GoogleFonts.roboto(
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
        return AddWeightDialog(
            selectedDay: selectedDay, textFormController: textFormController);
      },
    );
  }
}
