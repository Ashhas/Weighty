import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AddWeightScreen extends StatefulWidget {
  final Box dataBox;

  const AddWeightScreen({this.dataBox}) : super();

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
        backgroundColor: AppThemes.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppThemes.backgroundColor,
          title: Column(
            children: [
              Text(
                GlobalStrings.addWeightTitle,
                style: AppThemes.screenTitleTxtStyle,
              ),
              Text(
                GlobalStrings.addWeightLabel,
                style: AppThemes.screenLabelTxtStyle,
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
    print('CALLBACK: _onDaySelected');
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
                        style: AppThemes.weightNumberBigTxtStyle,
                      )),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADD WEIGHT",
                          style: AppThemes.smallBoldTxtStyle,
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
                            color: AppThemes.primaryColor,
                            onPressed: () {
                              widget.dataBox.add(MeasurementModel(selectedDay,
                                  double.parse(textFormController.text)));

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
