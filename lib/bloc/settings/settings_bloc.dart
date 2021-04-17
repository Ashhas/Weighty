import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsOpened());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsStarted) {
      yield* _mapDashboardStartedToState();
    }
  }

  Stream<SettingsState> _mapDashboardStartedToState() async* {
    yield SettingsLoading();

    yield SettingsLoaded();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
