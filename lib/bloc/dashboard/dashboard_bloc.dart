import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  MeasurementRepository measurementRepository;

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
    final MeasurementModel measurement =
        await measurementRepository.getLatestMeasurement();
    yield DashboardLoaded(measurement);
  }
}
