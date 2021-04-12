import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/bloc/app_theme/theme_bloc.dart';
import 'package:weighty/bloc/simple_bloc_observer.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/util/shared_pref_service.dart';
import 'package:weighty/util/strings.dart';

import 'package:weighty/util/themes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider<InitializationBloc>(
            create: (_) => InitializationBloc()..add(AppStarted()),
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
