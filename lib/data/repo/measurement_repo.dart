import 'package:hive/hive.dart';
import 'package:weighty/data/model/measurement.dart';

class MeasurementRepo {
  MeasurementRepo();

  Future<List<MeasurementModel>> getAllMeasurements() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    return _weightEntryDb.values.toList();
  }

  Future<MeasurementModel> getLatestMeasurement() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    return _weightEntryDb.values.last;
  }
}
