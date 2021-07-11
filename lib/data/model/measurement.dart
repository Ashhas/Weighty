import 'package:hive/hive.dart';

part 'measurement.g.dart';

@HiveType(typeId: 0)
class MeasurementModel extends HiveObject {
  @HiveField(0)
  DateTime dateAdded;
  @HiveField(1)
  double weightEntry;

  MeasurementModel(this.dateAdded, this.weightEntry);
}
