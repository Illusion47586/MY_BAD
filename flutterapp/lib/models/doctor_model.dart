// Package imports:
import 'package:hive/hive.dart';

part 'doctor_model.g.dart';

@HiveType(typeId: 1, adapterName: 'DoctorAdapter')
class DoctorModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageLink;

  @HiveField(3)
  String contact;

  DoctorModel({this.id, this.name, this.imageLink, this.contact});
}
