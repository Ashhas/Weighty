import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MeasurementRepository measurementRepository;

  DashboardBloc({@required this.measurementRepository})
      : super(DashboardOpened());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardStarted) {
      yield* _mapDashboardStartedToState();
    }
  }

  Stream<DashboardState> _mapDashboardStartedToState() async* {
    yield DashboardLoading();

    final sharedPrefService = await SharedPreferencesService.instance;
    String username = sharedPrefService.getUsername;

    final MeasurementModel measurement =
        await measurementRepository.getLatestMeasurement();

    yield DashboardLoaded(measurement, username);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
