import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/history/history_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/strings.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen() : super();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  CalendarController _calendarController;
  List<MeasurementModel> _fetchAllEvents;
  DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(HistoryStarted());
    _calendarController = CalendarController();
    _fetchAllEvents = List<MeasurementModel>();
    _currentMonth = DateTime.now();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            GlobalStrings.historyTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              _buildCustomHeader(),
              BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
                if (state is HistoryLoaded) {
                  _fetchAllEvents = state.allMeasurements;

                  return Expanded(
                    child: _buildSameMonthEventList(),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ));
  }

  Widget _buildCustomHeader() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
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
      ),
    );
  }

  Widget _buildSameMonthEventList() {
    var _sameMonthEventsFilter = _fetchAllEvents.where((element) =>
        element.dateAdded.year == _currentMonth.year &&
        element.dateAdded.month == _currentMonth.month);

    return Container(
        color: Theme.of(context).backgroundColor,
        child: (_sameMonthEventsFilter.length == 0)
            ? Center(
                child: Text("No appointment record in current month!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              )
            : ListView(
                children: _sameMonthEventsFilter
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
