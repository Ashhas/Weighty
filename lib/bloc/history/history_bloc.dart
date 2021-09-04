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
    if (event is NavigateToPreviousMonth) {
      yield* _mapNavigateToPreviousMonthToState();
    }
    if (event is NavigateToNextMonth) {
      yield* _mapNavigateToNextMonthToState();
    }
    if (event is EditMeasurement) {
      yield* _mapEditMeasurementToState(
          event.measurementModel, event.updatedWeight);
    }
    if (event is DeleteMeasurement) {
      yield* _mapDeleteMeasurementToState(event.measurementModel);
    }
  }

  Stream<HistoryState> _mapHistoryStartedToState() async* {
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> sortedMeasurements;

    yield HistoryLoading();

    //Retrieve all measurements
    allMeasurements = await measurementRepository.getAllMeasurements();

    //Sort Measurements based on date
    sortedMeasurements =
        await _sortMeasurementsByDateTopDown(measurements: allMeasurements);

    yield HistoryLoaded(sortedMeasurements);
  }

  Stream<HistoryState> _mapNavigateToPreviousMonthToState() async* {
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> sortedMeasurements;

    yield MonthChanged();

    yield HistoryLoading();

    //Retrieve all measurements
    allMeasurements = await measurementRepository.getAllMeasurements();

    //Sort Measurements based on date
    sortedMeasurements =
        await _sortMeasurementsByDateTopDown(measurements: allMeasurements);

    yield HistoryLoaded(sortedMeasurements);
  }

  Stream<HistoryState> _mapNavigateToNextMonthToState() async* {
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> sortedMeasurements;

    yield MonthChanged();

    yield HistoryLoading();

    //Retrieve all measurements
    allMeasurements = await measurementRepository.getAllMeasurements();

    //Sort Measurements based on date
    sortedMeasurements =
        await _sortMeasurementsByDateTopDown(measurements: allMeasurements);

    yield HistoryLoaded(sortedMeasurements);
  }

  Stream<HistoryState> _mapEditMeasurementToState(
      MeasurementModel measurementModel, String updatedWeight) async* {
    measurementModel.weightEntry = double.parse(updatedWeight.replaceAll(',', '.'));
    measurementRepository.editMeasurement(measurementModel);
  }

  Stream<HistoryState> _mapDeleteMeasurementToState(
      MeasurementModel measurementModel) async* {
    measurementRepository.deleteMeasurement(measurementModel);
  }

  Future<List<MeasurementModel>> _sortMeasurementsByDateTopDown(
      {List<MeasurementModel> measurements}) async {
    if (measurements != null) {
      //Sort based by date
      measurements.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

      return measurements;
    } else
      return null;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
