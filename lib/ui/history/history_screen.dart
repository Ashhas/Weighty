import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/history/history_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/constants/ui_const.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen() : super();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(HistoryStarted());
    _currentMonth = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
          ),
          _buildCustomHeader(),
          Divider(
            height: 1,
            thickness: 1,
          ),
          BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
            if (state is HistoryLoaded) {
              return state.allMeasurements != null
                  ? Expanded(
                      child: _buildSameMonthEventList(state.allMeasurements),
                    )
                  : Expanded(
                      child: Center(
                        child: Text("No weight entry added in this month!",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    );
            } else {
              return Container();
            }
          }),
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
            UiConst.historyTitle,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
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

  Widget _buildSameMonthEventList(List<MeasurementModel> fetchAllEvents) {
    List<MeasurementModel> _sameMonthEventsFilter = fetchAllEvents
        .where((element) =>
            element.dateAdded.year == _currentMonth.year &&
            element.dateAdded.month == _currentMonth.month)
        .toList();

    return Container(
      child: (_sameMonthEventsFilter.length == 0)
          ? Center(
              child: Text("No weight entry added in this month!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : ListView(
              children: _sameMonthEventsFilter
                  .map(
                    (event) => Dismissible(
                      key: ObjectKey(event),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DateFormat.yMMMMd('en_US')
                                        .format(event.dateAdded)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  event.weightEntry.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                            onTap: () {},
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                          ),
                        ],
                      ),
                      onDismissed: (direction) {
                        _sameMonthEventsFilter.remove(event);
                        BlocProvider.of<HistoryBloc>(context)
                            .add(DeleteMeasurement(event));
                      },
                    ),
                  )
                  .toList(),
            ),
    );
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
