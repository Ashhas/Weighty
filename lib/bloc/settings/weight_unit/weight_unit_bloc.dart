import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'weight_unit_event.dart';

part 'weight_unit_state.dart';

class WeightUnitBloc extends Bloc<WeightUnitEvent, WeightUnitState> {
  WeightUnitBloc() : super(WeightUnitsOpened());

  @override
  Stream<WeightUnitState> mapEventToState(WeightUnitEvent event) async* {
    if (event is WeightUnitStarted) {
      yield* _mapWeightUnitStartedToState();
    } else if (event is ChangeWeightUnit) {
      yield* _mapWeightUnitChangedToState(event.weightUnit);
    }
  }

  Stream<WeightUnitState> _mapWeightUnitStartedToState() async* {
    //Return current weightUnit
    final sharedPrefService = await SharedPreferencesService.instance;
    String weightUnit = sharedPrefService.getWeightUnitType;

    yield WeightUnitsLoaded(weightUnit: weightUnit);
  }

  Stream<WeightUnitState> _mapWeightUnitChangedToState(
      String weightUnitType) async* {
    yield WeightUnitsUpdated();

    //Save WeightUnit in Shared preferences
    final sharedPrefService = await SharedPreferencesService.instance;
    sharedPrefService.setWeightUnitType(weightUnitType);

    yield WeightUnitsLoaded(weightUnit: weightUnitType);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
