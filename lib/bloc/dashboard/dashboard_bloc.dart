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
    double amountLostThisWeek;
    String unitType;
    MeasurementModel firstMeasurement;
    MeasurementModel latestMeasurement;
    List<MeasurementModel> allMeasurements;
    List<MeasurementModel> filteredMeasurements;

    yield DashboardLoading();

    //Retrieve data from shared preferences
    final sharedPrefService = await SharedPreferencesService.instance;
    startWeight = sharedPrefService.getStartWeight;
    targetWeight = sharedPrefService.getTargetWeight;
    unitType = sharedPrefService.getWeightUnitType;

    //Retrieve data from database
    firstMeasurement = await measurementRepository.getFirstMeasurement();
    latestMeasurement = await measurementRepository.getLatestMeasurement();
    allMeasurements = await measurementRepository.getAllMeasurements();

    if (allMeasurements != null) {
      //Filter Measurements based on date range
      filteredMeasurements =
          await _filterMeasurementThisMonth(measurements: allMeasurements);

      //Calculation Methods
      percentageDone = _calculatePercentageDone(
        startWeight: startWeight,
        targetWeight: targetWeight,
        weightEntry: latestMeasurement.weightEntry,
      );
      totalLost = _calculateTotalLost(
        firstWeight: firstMeasurement.weightEntry,
        currentWeight: latestMeasurement.weightEntry,
      );
      amountLeft = _calculateAmountLeft(
        targetWeight: targetWeight,
        currentWeight: latestMeasurement.weightEntry,
      );
      amountLostThisWeek =
          await _calculateAmountLostThisWeek(measurements: allMeasurements);
    }

    yield DashboardLoaded(
        latestMeasurement,
        startWeight,
        targetWeight,
        percentageDone,
        totalLost,
        amountLeft,
        amountLostThisWeek,
        unitType,
        filteredMeasurements);
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

  double _calculateTotalLost({double firstWeight, double currentWeight}) {
    if (firstWeight < currentWeight) {
      return currentWeight - firstWeight;
    } else {
      return firstWeight - currentWeight;
    }
  }

  double _calculateAmountLeft({double targetWeight, double currentWeight}) {
    return currentWeight - targetWeight;
  }

  Future<double> _calculateAmountLostThisWeek(
      {List<MeasurementModel> measurements}) async {
    if (measurements != null) {
      //Filter
      List<MeasurementModel> filteredMeasurements = measurements
          .where((m) =>
              m.dateAdded.difference(DateTime.now()).inDays.abs() <= 7 &&
              m.dateAdded.isBefore(DateTime.now().add(Duration(days: 1))))
          .toList();

      filteredMeasurements.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));

      double lostThisWeek = filteredMeasurements.last.weightEntry -
          filteredMeasurements.first.weightEntry;

      return lostThisWeek;
    } else
      return null;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
