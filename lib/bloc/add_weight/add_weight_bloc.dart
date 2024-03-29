import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';

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
    final List<MeasurementModel> measurements =
        await measurementRepository.getAllMeasurements();

    yield AddWeightLoaded(measurements);
  }

  Stream<AddWeightState> _mapAddNewMeasurementToState(
      DateTime measurementDate, String measurementInput) async* {
    if (isToday(measurementDate)) {
      await measurementRepository.setNewMeasurement(MeasurementModel(
          DateTime.now(), double.parse(measurementInput.replaceAll(',', '.'))));
    } else {
      await measurementRepository.setNewMeasurement(MeasurementModel(
          measurementDate, double.parse(measurementInput.replaceAll(',', '.'))));
    }
  }

  bool isToday(DateTime dateToCheck) {
    return DateTime.now().year == dateToCheck.year &&
        DateTime.now().month == dateToCheck.month &&
        DateTime.now().day == dateToCheck.day;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
