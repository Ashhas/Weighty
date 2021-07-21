import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsOpened());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsStarted) {
      yield* _mapSettingsStartedToState();
    }
  }

  Stream<SettingsState> _mapSettingsStartedToState() async* {
    yield SettingsLoading();

    //Fetch App Version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    yield SettingsLoaded(appVersion: version);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
