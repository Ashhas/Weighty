import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/util/shared_pref_service.dart';
import 'package:weighty/util/strings.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.light));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoadStartedEvent) {
      yield* _mapThemeLoadStartedEventToState();
    } else if (event is ThemeChangedEvent) {
      yield* _mapThemeChangedEvenToState(event.themeDarkMode);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedEventToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final themeDarkMode = sharedPrefService.getThemeDarkMode;

    if (themeDarkMode == null) {
      sharedPrefService.setThemeDarkMode(false);
      yield ThemeState(ThemeMode.system);
    } else if (themeDarkMode == true) {
      yield ThemeState(ThemeMode.dark);
    } else if (themeDarkMode == false) {
      yield ThemeState(ThemeMode.light);
    }
  }

  Stream<ThemeState> _mapThemeChangedEvenToState(bool themeDarkMode) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    if (themeDarkMode == true) {
      sharedPrefService.setThemeDarkMode(true);
      yield ThemeState(ThemeMode.dark);
    } else if (themeDarkMode == false) {
      sharedPrefService.setThemeDarkMode(false);
      yield ThemeState(ThemeMode.light);
    }
  }
}
