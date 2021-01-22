import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barbones_architecture/util/theme.dart';
import 'package:barbones_architecture/ui/home_screen.dart';
import 'package:barbones_architecture/bloc/home/home_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()..add(HomeStarted()),
      child: MaterialApp(
        title: 'BareBones Project',
        theme: AppThemes.getLightTheme(),
        darkTheme: AppThemes.getDarkTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/cart': (context) => HomeScreen(),
        },
      ),
    );
  }
}
