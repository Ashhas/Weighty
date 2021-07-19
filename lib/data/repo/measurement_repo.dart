import 'package:hive/hive.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weighty/util/shared_pref_service.dart';

class MeasurementRepository {
  MeasurementRepository();

  Future<List<MeasurementModel>> getAllMeasurements() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');

    if (_weightEntryDb.values.isNotEmpty) {
      return _weightEntryDb.values.toList().cast<MeasurementModel>();
    } else
      return null;
  }

  Future<MeasurementModel> getFirstMeasurement() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');

    if (_weightEntryDb.values.isNotEmpty) {
      return _weightEntryDb.values.first;
    } else
      return null;
  }

  Future<MeasurementModel> getLatestMeasurement() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');

    if (_weightEntryDb.values.isNotEmpty) {
      return _weightEntryDb.values.last;
    } else
      return null;
  }

  Future<void> setNewMeasurement(MeasurementModel newMeasurement) async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    _weightEntryDb.add(newMeasurement);
  }

  void deleteMeasurement(MeasurementModel deletedMeasurement) async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    _weightEntryDb.delete(deletedMeasurement.delete());
  }
}
