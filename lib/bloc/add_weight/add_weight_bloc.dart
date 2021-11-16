import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/common_functions.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'add_weight_event.dart';

part 'add_weight_state.dart';

class AddWeightBloc extends Bloc<AddWeightEvent, AddWeightState> {
  final MeasurementRepository measurementRepository;

  AddWeightBloc({@required this.measurementRepository})
      : super(AddWeightOpened());

  @override
  Stream<AddWeightState> mapEventToState(AddWeightEvent event) async* {
    if (event is AddWeightStarted) {
      yield* _mapAddWeightStartedToState();
    } else if (event is AddNewMeasurement) {
      yield* _mapAddNewMeasurementToState(
          event.selectedDate, event.measurementInput);
    }
  }

  Stream<AddWeightState> _mapAddWeightStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    String unitType = sharedPrefService.getWeightUnitType;

    yield AddWeightLoaded(unitType: unitType);
  }

  Stream<AddWeightState> _mapAddNewMeasurementToState(
      DateTime measurementDate, String measurementInput) async* {
    if (CommonFunctions.isToday(measurementDate)) {
      await measurementRepository.setNewMeasurement(MeasurementModel(
          DateTime.now(), double.parse(measurementInput.replaceAll(',', '.'))));
    } else {
      await measurementRepository.setNewMeasurement(MeasurementModel(
          measurementDate,
          double.parse(measurementInput.replaceAll(',', '.'))));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
