import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/util/strings.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Column(
            children: [
              Text(
                GlobalStrings.addWeightTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                GlobalStrings.addWeightLabel,
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              daysOfWeekStyle:
                  DaysOfWeekStyle(weekendStyle: TextStyle(color: Colors.black)),
              calendarStyle: CalendarStyle(
                  highlightToday: true,
                  highlightSelected: true,
                  outsideDaysVisible: false,
                  weekendStyle: TextStyle(color: Colors.black)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
              ),
            ),
          ],
        ));
  }

  void _onDaySelected(DateTime selectedDay, List events, List holidays) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        (new DateFormat.yMMMd('en_US')
                            .format(selectedDay)
                            .toString()),
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADD WEIGHT",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextFormField(
                          controller: textFormController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              BlocProvider.of<AddWeightBloc>(context).add(
                                  AddNewMeasurement(
                                      selectedDay, textFormController.text));

                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              //Close Dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}
