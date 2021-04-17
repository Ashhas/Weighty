import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final MeasurementRepository measurementRepository;

  HistoryBloc({@required this.measurementRepository}) : super(HistoryOpened());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is HistoryStarted) {
      yield* _mapDashboardStartedToState();
    }
  }

  Stream<HistoryState> _mapDashboardStartedToState() async* {
    yield HistoryLoading();

    final List<MeasurementModel> measurements =
        await measurementRepository.getAllMeasurements();

    yield HistoryLoaded(measurements);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
