import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/ui/add_weight/add_weight_screen.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/ui/dashboard/dashboard_screen.dart';
import 'package:weighty/ui/history/history_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = UiConst.initialNavBarTab;

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
      default:
        return DashboardScreen();
        break;
    }
  }

  // Switch screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Determine bottom nav color based on the selectedIndex
  Color _chooseBottomNavColor() {
    switch (_selectedIndex) {
      case 1:
        return Theme.of(context).primaryColor;
        break;
      default:
        return Theme.of(context).bottomAppBarColor;
    }
  }

  // Determine selectedIcon color based on the selectedIndex
  Color _chooseSelectedItemColor() {
    switch (_selectedIndex) {
      case 1:
        return Colors.white;
        break;
      default:
        return Theme.of(context).focusColor;
    }
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
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
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
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: _chooseBottomNavColor(),
        selectedItemColor: _chooseSelectedItemColor(),
        unselectedItemColor: Theme.of(context).hintColor,
        elevation: 6.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
