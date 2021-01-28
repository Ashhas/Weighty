import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HistoryScreen extends StatefulWidget {
  final Box dataBox;

  const HistoryScreen({this.dataBox}) : super();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  CalendarController _calendarController;
  List<MeasurementModel> _sameMonthEvents;
  DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _sameMonthEvents = List<MeasurementModel>();
    _currentMonth = DateTime.now();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataBox != null) {
      _sameMonthEvents =
          widget.dataBox.values.toList().cast<MeasurementModel>();
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppThemes.backgroundColor,
          title: Text(
            GlobalStrings.historyTitle,
            style: AppThemes.screenTitleTxtStyle,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildCustomHeader(),
            Expanded(
              child: _buildsameMonthEventList(),
            ),
          ],
        ));
  }

  Widget _buildCustomHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectPreviousMonth();
              });
            },
          ),
          Text(
            DateFormat.yMMMM().format(_currentMonth),
            style: TextStyle(fontSize: 20.0),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectNextMonth();
              });
            },
          )
        ],
      )),
    );
  }

  Widget _buildsameMonthEventList() {
    var _samemontheventsFilter = _sameMonthEvents.where((element) =>
        element.dateAdded.year == _currentMonth.year &&
        element.dateAdded.month == _currentMonth.month);

    return Container(
        child: (_samemontheventsFilter.length == 0)
            ? Center(
                child: Text("No appointment record in current month!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              )
            : ListView(
                children: _samemontheventsFilter
                    .map((event) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: (event is MeasurementModel)
                            ? ListTile(
                                leading: Text(
                                  DateFormat.d().format(event.dateAdded) +
                                      '  ' +
                                      DateFormat.E().format(event.dateAdded),
                                ),
                                title: Text(event.weightEntry.toString()),
                                trailing: Icon(Icons.arrow_right),
                                onTap: () {},
                              )
                            : null))
                    .toList()));
  }

  void _selectPreviousMonth() {
    setState(() {
      if (_currentMonth.month == 1) {
        _currentMonth = DateTime(_currentMonth.year - 1, 12);
      } else {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      }
    });
  }

  void _selectNextMonth() {
    setState(() {
      if (_currentMonth.month == 12) {
        _currentMonth = DateTime(_currentMonth.year + 1, 1);
      } else {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      }
    });
  }
}
