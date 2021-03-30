import 'package:weighty/bloc/app_theme/theme_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/util/shared_pref_service.dart';
import 'package:weighty/util/strings.dart';

import 'package:weighty/util/theme.dart';
import 'package:weighty/bloc/home/navigation_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //Hive initialization
  _initializeHiveDb();

  //Set SharedPrefs
  _setPrefsData();

  //Run app
  runApp(MyApp());
}

Future<void> _setPrefsData() async {
  final sharedPrefService = await SharedPreferencesService.instance;
  sharedPrefService.setUsername('David Brown');
  sharedPrefService.setWeightUnitType('KG');
  sharedPrefService.setReminderStatus(false);
  sharedPrefService.setStartWeight(120.0);
  sharedPrefService.setStartWeightDate('2020-01-01 00:00:00.000');
  sharedPrefService.setTargetWeight(100.0);
  sharedPrefService.setTargetWeightDate('2020-04-01 00:00:00.000');
}

Future<void> _initializeHiveDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MeasurementModelAdapter());

  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  // Open DB
  Box _weightInfo = await Hive.openBox('weightInfo');

  //Create Fake Data
  var entry1 = MeasurementModel(DateTime.now(), 200);
  _weightInfo.add(entry1);
  var entry2 = MeasurementModel(DateTime.now(), 115);
  _weightInfo.add(entry2);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider<NavigationBloc>(
    //   create: (_) => NavigationBloc()..add(NavigateToDashboard()),
    //   child: MaterialApp(
    //     title: 'Weighty',
    //     home: BottomNavBar(),
    //   ),
    // );

    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (_) => NavigationBloc()..add(NavigateToDashboard()),
          ),
          BlocProvider<ThemeBloc>(
              create: (_) => ThemeBloc()..add(ThemeLoadStartedEvent()))
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Weighty',
              themeMode: themeState.themeMode,
              theme: AppThemes.getLightTheme(),
              darkTheme: AppThemes.getDarkTheme(),
              home: BottomNavBar(),
            );
          },
        ));
  }
}
