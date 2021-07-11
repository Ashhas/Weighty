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
      yield* _mapHistoryStartedToState();
    }
    if (event is DeleteMeasurement) {
      yield* _mapDeleteMeasurementToState(event.measurementModel);
    }
  }

  Stream<HistoryState> _mapHistoryStartedToState() async* {
    yield HistoryLoading();

    final List<MeasurementModel> measurements =
        await measurementRepository.getAllMeasurements();
    var sortedMeasurements =
        new List<MeasurementModel>.from(measurements.reversed);

    yield HistoryLoaded(sortedMeasurements);
  }

  Stream<HistoryState> _mapDeleteMeasurementToState(
      MeasurementModel measurementModel) async* {
    measurementRepository.deleteMeasurement(measurementModel);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
