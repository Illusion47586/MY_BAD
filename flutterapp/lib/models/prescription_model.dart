// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:medico/models/medicine_model.dart';

part 'prescription_model.g.dart';

@HiveType(typeId: 3, adapterName: 'PrescriptionAdapter')
class PrescriptionModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  HiveList<MedicineModel> medicines;

  @HiveField(2)
  DateTime prescribedOn;

  @HiveField(3)
  bool revisitNeeded;

  @HiveField(4)
  DateTime revisitOn;

  @HiveField(5)
  String doctorID;

  @HiveField(6)
  String note;

  @HiveField(7)
  String diseaseName;

  PrescriptionModel({
    this.id,
    this.diseaseName,
    this.note,
    this.doctorID,
    this.medicines,
    this.prescribedOn,
    this.revisitNeeded,
    this.revisitOn,
  });
}
