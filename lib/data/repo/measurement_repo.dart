import 'package:hive/hive.dart';
import 'package:weighty/data/model/measurement.dart';

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

  Future<MeasurementModel> getCurrentMeasurement() async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    List<MeasurementModel> sortedList;

    if (_weightEntryDb.values.isNotEmpty) {
      sortedList = _weightEntryDb.values.toList().cast<MeasurementModel>();

      //Sort Measurement based on date
      sortedList.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));

      return sortedList.last;
    } else
      return null;
  }

  Future<void> setNewMeasurement(MeasurementModel newMeasurement) async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    _weightEntryDb.add(newMeasurement);
  }

  void editMeasurement(MeasurementModel updatedMeasurement) async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    _weightEntryDb.delete(updatedMeasurement.delete());
    _weightEntryDb.add(updatedMeasurement);
  }

  void deleteMeasurement(MeasurementModel deletedMeasurement) async {
    Box _weightEntryDb = await Hive.openBox('weightInfo');
    _weightEntryDb.delete(deletedMeasurement.delete());
  }
}
