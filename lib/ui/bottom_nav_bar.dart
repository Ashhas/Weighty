import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/ui/add_weight/add_weight_screen.dart';
import 'package:weighty/ui/settings/settings_screen.dart';
import 'package:weighty/ui/weight_chart_screen/weight_chart_screen.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/ui/dashboard/dashboard_screen.dart';
import 'package:weighty/ui/history/history_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _navPages(int index) {
    switch (index) {
      case 0:
        return DashboardScreen();
        break;
      case 1:
        return WeightChartScreen();
        break;
      case 2:
        return AddWeightScreen();
        break;
      case 3:
        return HistoryScreen();
        break;
      case 4:
        return SettingsScreen();
        break;
      default:
        return DashboardScreen();
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InitializationBloc, InitializationState>(
        builder: (context, state) {
          if (state is Initialized) {
            return Center(
              child: _navPages(_selectedIndex),
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: GlobalStrings.dashboardTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart),
              label: GlobalStrings.statisticsTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: GlobalStrings.addTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: GlobalStrings.historyTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: GlobalStrings.settingsTitle),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).focusColor,
        unselectedItemColor: Theme.of(context).shadowColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
