import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/export_handler.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'export_event.dart';

part 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final MeasurementRepository measurementRepository;

  ExportBloc({@required this.measurementRepository})
      : super(ExportInitialState());

  @override
  Stream<ExportState> mapEventToState(ExportEvent event) async* {
    if (event is StartExport) {
      yield* _mapStartExportToState();
    }
  }

  Stream<ExportState> _mapStartExportToState() async* {
    double targetWeight;
    MeasurementModel currentMeasurement;
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> sortedMeasurements;

    yield ExportStart();

    //Retrieve data from shared preferences
    final sharedPrefService = await SharedPreferencesService.instance;
    targetWeight = sharedPrefService.getTargetWeight;

    //Retrieve data from database
    currentMeasurement = await measurementRepository.getCurrentMeasurement();
    allMeasurements = await measurementRepository.getAllMeasurements();

    if (allMeasurements != null) {
      //Sort Measurements based on date
      sortedMeasurements =
          await _sortMeasurementsByDate(measurements: allMeasurements);

      //Do Export to Excel
      ExportHandler.generateExcel(
          sortedMeasurements, currentMeasurement, targetWeight);
    }

    yield ExportFinished();
  }

  Future<List<MeasurementModel>> _sortMeasurementsByDate(
      {List<MeasurementModel> measurements}) async {
    if (measurements != null) {
      //Sort based by date
      measurements.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));

      return measurements;
    } else
      return null;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
