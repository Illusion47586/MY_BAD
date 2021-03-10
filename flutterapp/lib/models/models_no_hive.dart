// Project imports:
import '../common/enums.dart';

class DoctorModel {
  String id;
  String name;
  String imageLink;
  String contact;

  DoctorModel({this.id, this.name, this.imageLink, this.contact});
}

class MedicineModel {
  String id;
  String name;
  MedicineType type;
  double quantity;
  List<String> timing;
  String duration;
  String note;

  MedicineModel({
    this.id,
    this.name,
    this.type,
    this.quantity,
    this.timing,
    this.duration,
    this.note,
  });
}

class PatientModel {
  String id;
  String name;
  int age;
  int gender;
  String occupation;
  String imageLink;
  double height;
  double weight;
  String contact;

  PatientModel({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.imageLink,
    this.occupation,
    this.contact,
  });
}

class PrescriptionModel {
  String id;
  List<MedicineModel> medicines;
  DateTime prescribedOn;
  bool revisitNeeded;
  DateTime revisitOn;
  String doctorID;
  String note;
  String diseaseName;
  String duration;

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
