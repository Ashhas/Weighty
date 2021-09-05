import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
    double startWeight;
    double targetWeight;
    double percentageDone;
    double totalLost;
    double amountLeft;
    String unitType;
    MeasurementModel currentMeasurement;
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> filteredMeasurements;
    List<MeasurementModel> sortedMeasurements;

    yield DashboardLoading();

    //Retrieve data from shared preferences
    final sharedPrefService = await SharedPreferencesService.instance;
    startWeight = sharedPrefService.getStartWeight;
    targetWeight = sharedPrefService.getTargetWeight;
    unitType = sharedPrefService.getWeightUnitType;

    //Retrieve data from database
    currentMeasurement = await measurementRepository.getCurrentMeasurement();
    allMeasurements = await measurementRepository.getAllMeasurements();

    if (allMeasurements != null) {
      //Filter Measurements based on date range
      filteredMeasurements =
          await _filterMeasurementThisMonth(measurements: allMeasurements);

      //Sort Measurements based on date
      sortedMeasurements =
          await _sortMeasurementsByDate(measurements: filteredMeasurements);

      //Calculation Methods
      percentageDone = _calculatePercentageDone(
        startWeight: startWeight,
        targetWeight: targetWeight,
        weightEntry: currentMeasurement.weightEntry,
      );
      totalLost = _calculateTotalLost(
        startWeight: startWeight,
        currentWeight: currentMeasurement.weightEntry,
      );
      amountLeft = _calculateAmountLeft(
        targetWeight: targetWeight,
        currentWeight: currentMeasurement.weightEntry,
      );
    }

    yield DashboardLoaded(currentMeasurement, startWeight, targetWeight,
        percentageDone, totalLost, amountLeft, unitType, sortedMeasurements);
  }

  Future<List<MeasurementModel>> _filterMeasurementThisMonth(
      {List<MeasurementModel> measurements}) async {
    if (measurements != null) {
      //Filter
      List<MeasurementModel> filteredMeasurements = measurements
          .where((m) => m.dateAdded.month == DateTime.now().month)
          .toList();

      return filteredMeasurements;
    } else
      return null;
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

  double _calculatePercentageDone(
      {double startWeight, double targetWeight, double weightEntry}) {
    double calculatedPercentage =
        ((startWeight - weightEntry) * 100 / (startWeight - targetWeight));

    if (calculatedPercentage < 0) {
      return 0;
    } else if (calculatedPercentage > 100) {
      return 1;
    } else {
      return calculatedPercentage / 100;
    }
  }

  double _calculateTotalLost({double startWeight, double currentWeight}) {
    if (startWeight < currentWeight) {
      return currentWeight - startWeight;
    } else {
      return startWeight - currentWeight;
    }
  }

  double _calculateAmountLeft({double targetWeight, double currentWeight}) {
    return currentWeight - targetWeight;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
