import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/shared_pref_service.dart';

part 'initialization_event.dart';

part 'initialization_state.dart';

class InitializationBloc
    extends Bloc<InitializationEvent, InitializationState> {
  InitializationBloc() : super(InitStarted());

  @override
  Stream<InitializationState> mapEventToState(
      InitializationEvent event) async* {
    if (event is InitializeApp) {
      yield* _mapInitializeAppEventToState();
    } else if (event is FinishOnBoarding) {
      yield* _mapOnBoardingFinishedEventToState();
    }
  }

  Stream<InitializationState> _mapInitializeAppEventToState() async* {
    //Delay for Splash Screen
    await Future.delayed(Duration(seconds: 1));

    //Adding Fake Goal Data
    final sharedPrefService = await SharedPreferencesService.instance;
    final onBoardingSeenBefore = sharedPrefService.getOnBoardingSeenBefore;

    //Initializing Hive DB
    await Hive.initFlutter();
    Hive.registerAdapter(MeasurementModelAdapter());
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    if (onBoardingSeenBefore == null) {
      yield Uninitialized();
    } else if (onBoardingSeenBefore == false) {
      yield Uninitialized();
    } else if (onBoardingSeenBefore == true) {
      yield Initialized();
    }
  }

  Stream<InitializationState> _mapOnBoardingFinishedEventToState() async* {
    //Check if OnBoarding has been finished
    final sharedPrefService = await SharedPreferencesService.instance;
    final onBoardingSeenBefore = sharedPrefService.getOnBoardingSeenBefore;

    if (onBoardingSeenBefore == null) {
      yield Uninitialized();
    } else if (onBoardingSeenBefore == false) {
      yield Uninitialized();
    } else if (onBoardingSeenBefore == true) {
      yield Initialized();
    }
  }
}
