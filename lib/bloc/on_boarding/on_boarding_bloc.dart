import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'on_boarding_event.dart';

part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final MeasurementRepository measurementRepository;

  OnBoardingBloc({@required this.measurementRepository})
      : super(OnBoardingOpenedState());

  @override
  Stream<OnBoardingState> mapEventToState(OnBoardingEvent event) async* {
    if (event is AddedStartWeight) {
      yield* _mapAddedStartWeightToState(event, state);
    } else if (event is AddedWeightGoal) {
      yield* _mapAddedWeightGoalToState(event, state);
    }
  }

  Stream<OnBoardingState> _mapAddedStartWeightToState(
      AddedStartWeight event, OnBoardingState state) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    //Saving Initial StartWeight
    sharedPrefService.setStartWeight(double.parse(event.startWeight));

    //Add first entry to db
    Box _weightInfo = await Hive.openBox('weightInfo');
    _weightInfo
        .add(MeasurementModel(DateTime.now(), double.parse(event.startWeight)));
  }

  Stream<OnBoardingState> _mapAddedWeightGoalToState(
      AddedWeightGoal event, OnBoardingState state) async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    //Saving Initial TargetWeight
    sharedPrefService.setTargetWeight(double.parse(event.targetWeight));

    //Set OnBoarding as seen
    sharedPrefService.setOnBoardingSeenBefore(true);

    yield OnBoardingFinished();
  }
}
