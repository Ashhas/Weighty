import 'file:///E:/Personal/Projects/Weighty/lib/ui/dashboard/dashboard_screen.dart';
import 'file:///E:/Personal/Projects/Weighty/lib/ui/history/history_screen.dart';
import 'package:weighty/bloc/home/navigation_bloc.dart';
import 'package:weighty/ui/addweight/add_weight_screen.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  Box _weightEntryDb;
  NavigationBloc navigationBloc;

  @override
  void initState() {
    super.initState();

    navigationBloc = BlocProvider.of<NavigationBloc>(context);

    _initDataBox();
  }

  Future _initDataBox() async {
    // Create DB
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _weightEntryDb = await Hive.openBox('weightInfo');
  }

  Widget _navPages(int index) {
    switch (index) {
      case 0:
        return DashboardScreen(
          dataBox: _weightEntryDb,
        );
        break;
      case 1:
        return Text(
          'Index 1: Business',
        );
        break;
      case 2:
        return AddWeightScreen(
          dataBox: _weightEntryDb,
        );
        break;
      case 3:
        return HistoryScreen();
        break;
      case 4:
        return Text(
          'Index 2: School',
        );
        break;
      default:
        return DashboardScreen();
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      navigationBloc.add(NavigateToDashboard());
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navPages(_selectedIndex),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
