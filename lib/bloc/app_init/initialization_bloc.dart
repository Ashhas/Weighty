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
  InitializationBloc() : super(Uninitialized());

  @override
  Stream<InitializationState> mapEventToState(
      InitializationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedEventToState();
    }
  }

  Stream<InitializationState> _mapAppStartedEventToState() async* {
    yield CreatingTestDataState();

    //Setting SharedPref Data
    final sharedPrefService = await SharedPreferencesService.instance;
    sharedPrefService.setUsername('David Brown');
    sharedPrefService.setWeightUnitType('KG');
    sharedPrefService.setReminderStatus(false);
    sharedPrefService.setStartWeight(120.0);
    sharedPrefService.setStartWeightDate('2020-01-01 00:00:00.000');
    sharedPrefService.setTargetWeight(100.0);
    sharedPrefService.setTargetWeightDate('2020-04-01 00:00:00.000');

    //Initializing Hive DB
    await Hive.initFlutter();
    Hive.registerAdapter(MeasurementModelAdapter());
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    // Open DB
    Box _weightInfo = await Hive.openBox('weightInfo');

    //Create Fake Data
    var entry1 = MeasurementModel(DateTime(2021, 2, 24), 120);
    _weightInfo.add(entry1);
    var entry2 = MeasurementModel(DateTime(2021, 3, 14), 115);
    _weightInfo.add(entry2); //Create Fake Data
    var entry3 =
        MeasurementModel(DateTime.now().subtract(Duration(days: 1)), 113);
    _weightInfo.add(entry3);
    var entry4 = MeasurementModel(DateTime.now(), 109);
    _weightInfo.add(entry4);

    yield Initialized();
  }
}
