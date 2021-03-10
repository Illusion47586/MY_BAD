// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrescriptionAdapter extends TypeAdapter<PrescriptionModel> {
  @override
  final int typeId = 3;

  @override
  PrescriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrescriptionModel(
      id: fields[0] as String,
      diseaseName: fields[7] as String,
      note: fields[6] as String,
      doctorID: fields[5] as String,
      medicines: (fields[1] as HiveList)?.castHiveList(),
      prescribedOn: fields[2] as DateTime,
      revisitNeeded: fields[3] as bool,
      revisitOn: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PrescriptionModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicines)
      ..writeByte(2)
      ..write(obj.prescribedOn)
      ..writeByte(3)
      ..write(obj.revisitNeeded)
      ..writeByte(4)
      ..write(obj.revisitOn)
      ..writeByte(5)
      ..write(obj.doctorID)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.diseaseName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
