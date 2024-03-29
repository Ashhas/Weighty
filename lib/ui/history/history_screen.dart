import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/history/history_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/history/widgets/edit_weight_dialog.dart';
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
          _buildCustomHeader(),
          BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
            if (state is HistoryLoaded) {
              return state.allMeasurements != null
                  ? Expanded(
                      child: _buildSameMonthEventList(state.allMeasurements),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          UiConst.noHistoryDataTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
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
      height: 50,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () {
                setState(() {
                  _selectPreviousMonth();
                });
              },
            ),
            Text(
              DateFormat.yMMMM().format(_currentMonth),
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, color: Colors.white),
              onPressed: () {
                setState(() {
                  _selectNextMonth();
                });
              },
            )
          ],
        ),
      ),
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
              child: Text(
                UiConst.monthFilterNoDataTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
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
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                                Text(
                                  event.weightEntry.toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                )
                              ],
                            ),
                            onTap: () {},
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditWeightDialog(
                                      selectedMeasurement: event);
                                },
                              );
                            },
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
    if (_currentMonth.month == 1) {
      _currentMonth = DateTime(_currentMonth.year - 1, 12);
    } else {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    }
    BlocProvider.of<HistoryBloc>(context).add(NavigateToPreviousMonth());
  }

  void _selectNextMonth() {
    if (_currentMonth.month == 12) {
      _currentMonth = DateTime(_currentMonth.year + 1, 1);
    } else {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    }

    BlocProvider.of<HistoryBloc>(context).add(NavigateToNextMonth());
  }
}
