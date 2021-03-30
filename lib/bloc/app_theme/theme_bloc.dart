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
  ThemeBloc(ThemeState initialState) : super(initialState);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoadStartedEvent) {
      yield* _mapThemeLoadStartedEventToState();
    } else if (event is ThemeChangedEvent) {
      yield* _mapThemeChangedEvenToState(event.themeModeString);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedEventToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final selectedThemeMode = sharedPrefService.getThemeMode;

    if (selectedThemeMode == null) {
      sharedPrefService.setThemeMode(GlobalStrings.systemTheme);
      yield CurrentThemeState(ThemeMode.system);
    } else if (selectedThemeMode == GlobalStrings.darkTheme) {
      yield CurrentThemeState(ThemeMode.dark);
    } else if (selectedThemeMode == GlobalStrings.lightTheme) {
      yield CurrentThemeState(ThemeMode.light);
    }
  }

  Stream<ThemeState> _mapThemeChangedEvenToState(
      String selectedThemeMode) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    if (selectedThemeMode == GlobalStrings.systemTheme) {
      sharedPrefService.setThemeMode(GlobalStrings.systemTheme);
      yield CurrentThemeState(ThemeMode.system);
    } else if (selectedThemeMode == GlobalStrings.darkTheme) {
      sharedPrefService.setThemeMode(GlobalStrings.darkTheme);
      yield CurrentThemeState(ThemeMode.dark);
    } else if (selectedThemeMode == GlobalStrings.lightTheme) {
      sharedPrefService.setThemeMode(GlobalStrings.lightTheme);
      yield CurrentThemeState(ThemeMode.light);
    }
  }
}
