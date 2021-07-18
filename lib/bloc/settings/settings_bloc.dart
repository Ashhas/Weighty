import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final MeasurementRepository measurementRepository;

  SettingsBloc({this.measurementRepository}) : super(SettingsOpened());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsStarted) {
      yield* _mapSettingsStartedToState();
    }
  }

  Stream<SettingsState> _mapSettingsStartedToState() async* {
    yield SettingsLoading();

    //User Information
    final sharedPrefService = await SharedPreferencesService.instance;
    double startWeight = sharedPrefService.getStartWeight;
    String startWeightDate = sharedPrefService.getStartWeightDate;
    double targetWeight = sharedPrefService.getTargetWeight;
    String targetWeightDate = sharedPrefService.getTargetWeightDate;

    //Latest Weight Entry from DB
    MeasurementModel latestMeasurement =
        await measurementRepository.getLatestMeasurement();

    //Fetch App Version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    yield SettingsLoaded(
        appVersion: version,
        startWeight: startWeight,
        startWeightDate: startWeightDate,
        targetWeight: targetWeight,
        targetWeightDate: targetWeightDate,
        currentWeight: latestMeasurement.weightEntry);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
