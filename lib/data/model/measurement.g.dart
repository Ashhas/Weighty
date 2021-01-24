// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementModelAdapter extends TypeAdapter<MeasurementModel> {
  @override
  final int typeId = 0;

  @override
  MeasurementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeasurementModel(
      fields[0] as DateTime,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MeasurementModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dateAdded)
      ..writeByte(1)
      ..write(obj.weightEntry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
