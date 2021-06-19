import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/bloc/history/history_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';
import 'package:weighty/bloc/settings/settings_bloc.dart';
import 'package:weighty/bloc/simple_bloc_observer.dart';
import 'package:weighty/bloc/theme/theme_bloc.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';
import 'package:weighty/util/constants/theme_const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Bloc Observer
  Bloc.observer = SimpleBlocObserver();

  //Run app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeasurementRepository measurementRepository = MeasurementRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MeasurementRepository>(
          create: (context) => measurementRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InitializationBloc>(
            create: (_) => InitializationBloc()..add(AppStarted()),
          ),
          BlocProvider<ThemeBloc>(
              create: (_) => ThemeBloc()..add(ThemeLoadStarted())),
          BlocProvider<DashboardBloc>(
              create: (_) =>
                  DashboardBloc(measurementRepository: measurementRepository)),
          BlocProvider<HistoryBloc>(
              create: (_) =>
                  HistoryBloc(measurementRepository: measurementRepository)),
          BlocProvider<AddWeightBloc>(
              create: (_) =>
                  AddWeightBloc(measurementRepository: measurementRepository)),
          BlocProvider<SettingsBloc>(
              create: (_) =>
                  SettingsBloc(measurementRepository: measurementRepository)),
          BlocProvider<GoalsBloc>(
              create: (_) =>
                  GoalsBloc(measurementRepository: measurementRepository))
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            if (themeState is CurrentThemeState) {
              return MaterialApp(
                title: 'Weighty',
                themeMode: themeState.themeMode,
                theme: AppTheme.getLightTheme(),
                darkTheme: AppTheme.getDarkTheme(),
                home: BottomNavBar(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
