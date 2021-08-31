import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/ui/add_weight/add_weight_screen.dart';
import 'package:weighty/ui/settings/settings_screen.dart';
import 'package:weighty/util/constants/ui_const.dart';
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
        return AddWeightScreen();
        break;
      case 2:
        return HistoryScreen();
        break;
      case 3:
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
            label: UiConst.dashboardTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: UiConst.addTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: UiConst.historyTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_sharp),
            label: UiConst.settingsTitle,
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).focusColor,
        unselectedItemColor: Theme.of(context).hintColor,
        elevation: 6.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
