// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:medico/common/enums.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 2, adapterName: 'MedicineAdapter')
class MedicineModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  MedicineType type;
  @HiveField(3)
  double quantity;
  @HiveField(4)
  List<String> timing;
  @HiveField(6)
  String duration;
  @HiveField(7)
  String note;
  // Hive fields go here

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
