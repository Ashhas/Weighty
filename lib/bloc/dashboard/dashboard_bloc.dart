import 'dart:async';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

    //Get Data from SharePref
    final sharedPrefService = await SharedPreferencesService.instance;
    String username = sharedPrefService.getUsername;
    double startWeight = sharedPrefService.getStartWeight;
    String startWeightDate = new DateFormat.yMMMd('en_US')
        .format(DateTime.parse(sharedPrefService.getStartWeightDate));
    double targetWeight = sharedPrefService.getTargetWeight;
    String targetWeightDate = new DateFormat.yMMMd('en_US')
        .format(DateTime.parse(sharedPrefService.getTargetWeightDate));

    //Get Latest Measurement from DB
    MeasurementModel latestMeasurement =
        await measurementRepository.getLatestMeasurement();

    //Get Filtered Measurements for 2 Months
    List<MeasurementModel> filteredMeasurements =
        await _filterMeasurementTwoMonths();

    //Calculate Percentage Done
    double percentageDone = _calculatePercentageDone(
      startWeight,
      targetWeight,
      latestMeasurement.weightEntry,
    );

    yield DashboardLoaded(
        latestMeasurement,
        username,
        startWeight,
        startWeightDate,
        targetWeight,
        targetWeightDate,
        percentageDone,
        filteredMeasurements);
  }

  Future<List<MeasurementModel>> _filterMeasurementTwoMonths() async {
    List<MeasurementModel> allMeasurements =
        await measurementRepository.getAllMeasurements();

    //Filter
    List<MeasurementModel> filteredMeasurements = allMeasurements
        .where((m) =>
            m.dateAdded.difference(DateTime.now()).inDays.abs() <= 60 &&
            m.dateAdded.isBefore(DateTime.now().add(Duration(days: 1))))
        .toList();

    filteredMeasurements.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));

    return filteredMeasurements;
  }

  double _calculatePercentageDone(
      double startWeight, double targetWeight, double weightEntry) {
    return ((startWeight - weightEntry) * 100 / (startWeight - targetWeight));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
