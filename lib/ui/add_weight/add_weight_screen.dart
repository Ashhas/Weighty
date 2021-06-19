import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/ui/add_weight/widgets/add_weight_dialog.dart';
import 'package:weighty/util/constants/ui_const.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen() : super();

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final textFormController = TextEditingController();
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    BlocProvider.of<AddWeightBloc>(context).add(AddWeightStarted());
  }

  @override
  void dispose() {
    _calendarController.dispose();
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
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.black),
            ),
            calendarStyle: CalendarStyle(
              highlightToday: true,
              highlightSelected: true,
              outsideDaysVisible: false,
              weekendStyle: TextStyle(color: Colors.black),
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
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

  void _onDaySelected(DateTime selectedDay, List events, List holidays) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddWeightDialog(
            selectedDay: selectedDay, textFormController: textFormController);
      },
    );
  }
}
