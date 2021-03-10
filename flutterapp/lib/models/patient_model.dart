// Package imports:
import 'package:hive/hive.dart';

part 'patient_model.g.dart';

@HiveType(typeId: 0, adapterName: 'PatientAdapter')
class PatientModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int age;

  @HiveField(3)
  int gender;

  @HiveField(4)
  String occupation;

  @HiveField(5)
  String imageLink;

  @HiveField(6)
  double height;

  @HiveField(7)
  double weight;

  @HiveField(8)
  String contact;
  // Hive fields go here

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
