// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

// Project imports:
import '../common/common_vals.dart';
import '../models/models_no_hive.dart';

// ignore: must_be_immutable
class MedicineProvider extends ChangeNotifier {
  PrescriptionModel _prescription;
  final Dio dio = Dio();
  final String pid = '';
  // Box prescriptionBox;
  DoctorModel myDoc;
  MedicineModel currMedicine;

  MedicineProvider() {
    // Hive.deleteBoxFromDisk('PrescriptionAdapter');
    print('hello');
    // fetchData().then((value) => print('here'));
  }

  Future<void> fetchData() async {
    final data = await dio.get(
      fetchLink + '/getprescription',
      queryParameters: {
        'pid': pid,
      },
    );
    Logger().d(data.data[0]);
    // final tempPres = json.decode(data.data[0].toString());
    final tempPres = data.data[0];
    Logger().d(tempPres);
    final note = tempPres['note'] ?? '';
    final duration = tempPres['duration'] ?? '2 weeks';
    final diseaseName = tempPres['diagnosedWith'];
    final doctorId = tempPres['prescribedBy'];
    final revisitNeeded = tempPres['revisitNeeded'] ?? false;
    final MedicineModel m = MedicineModel(
      name: tempPres['med1Medname'],
      type: tempPres['med1Type'],
      timing: tempPres['med1Timing'].split(' ') ?? [],
      duration: tempPres['med1Duration'],
    );
    // final medicines = tempPres.Medicine;
    final List<MedicineModel> medicineList = [m];
    // for (var medicine in medicines) {
    //   final MedicineModel medicineModel = MedicineModel(
    //     name: medicine.name,
    //     type: MedicineType.pill,
    //     quantity: medicine.quantity,
    //     timing: medicine.timing,
    //     duration: medicine.duration,
    //     note: medicine.note ?? '',
    //   );
    //   medicineList.add(medicineModel);
    // }
    _prescription.diseaseName = diseaseName;
    _prescription.doctorID = doctorId;
    _prescription.revisitNeeded = revisitNeeded;
    _prescription.medicines = medicineList;
    _prescription.note = note;
    _prescription.duration = duration;
    // await prescriptionBox.add(_prescription);
    fetchDoctor(doctorId);
    notifyListeners();
  }

  void fetchDoctor(String did) async {
    if (myDoc == null) {
      final data = await dio.get(
        fetchLink + '/doctor',
        queryParameters: {
          'id': did,
        },
      );
      final docData = json.decode(data.data);
      if (docData.image) {
        // final result = await base64ToImage(docData.image, docData.id);
        myDoc = DoctorModel(
          id: did,
          name: docData.name,
          imageLink: 'https://randomuser.me/api/portraits/men/64.jpg',
          contact: docData.contact,
        );
      } else {
        myDoc = DoctorModel(
          id: did,
          name: docData['name'],
          imageLink: 'https://randomuser.me/api/portraits/men/64.jpg',
          contact: docData['contact'],
        );
      }
    }
  }

  void setPrescription(PrescriptionModel pres) {
    _prescription = pres;
  }

  void setCurrMedicine(MedicineModel medicine) {
    currMedicine = medicine;
    notifyListeners();
  }

  PrescriptionModel get getPrescription => _prescription;
  DoctorModel get getDoctor => myDoc;
  MedicineModel get getCurrMedicine => currMedicine;
}
