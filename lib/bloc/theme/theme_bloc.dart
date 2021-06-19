import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(CurrentThemeState(themeMode: ThemeMode.light));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoadStarted) {
      yield* _mapThemeLoadStartedEventToState();
    } else if (event is ThemeChanged) {
      yield* _mapThemeChangedEvenToState(event.themeDarkMode);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedEventToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final themeDarkMode = sharedPrefService.getThemeDarkMode;

    if (themeDarkMode == null) {
      sharedPrefService.setThemeDarkMode(false);
      yield CurrentThemeState(
          themeMode: ThemeMode.system, isDarkTheme: themeDarkMode);
    } else if (themeDarkMode == true) {
      yield CurrentThemeState(
          themeMode: ThemeMode.dark, isDarkTheme: themeDarkMode);
    } else if (themeDarkMode == false) {
      yield CurrentThemeState(
          themeMode: ThemeMode.light, isDarkTheme: themeDarkMode);
    }
  }

  Stream<ThemeState> _mapThemeChangedEvenToState(bool themeDarkMode) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    yield ThemeHasChanged();

    if (themeDarkMode == true) {
      sharedPrefService.setThemeDarkMode(true);
      yield CurrentThemeState(
          themeMode: ThemeMode.dark, isDarkTheme: themeDarkMode);
    } else if (themeDarkMode == false) {
      sharedPrefService.setThemeDarkMode(false);
      yield CurrentThemeState(
          themeMode: ThemeMode.light, isDarkTheme: themeDarkMode);
    }
  }
}
