// Dart imports:
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:provider/provider.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';

// Project imports:
import 'package:medico/providers/prescription_provider.dart';
import '../common/common_vals.dart';
import '../common/enums.dart';
import '../models/models_no_hive.dart';

Future<void> ocrHelper(ui.Image image, BuildContext context) async {
  final byte = await image.toByteData(format: ui.ImageByteFormat.png);
  final byteList = byte.buffer.asUint8List();

  final dir = await p.getTemporaryDirectory();
  final imageFile = File(
    dir.path + '/pres.png',
  );

  final result = await imageFile.writeAsBytes(byteList);

  try {
    final String _resultString = await SimpleOcrPlugin.performOCR(result.path);
    final data = json.decode(_resultString);
    final data1 = [];
    data['text'].split('  ').forEach((e) => {data1.add(e.toString().trim())});
    String diseaseName;
    final List<MedicineModel> medicines = [];

    // final data1 = data.text.split('  ');
    Logger().d('OCR results => $data1');

    for (var i = 0; i < data1.length; i++) {
      // if (i == 0) diseaseName = data1[0];
      if (data1[i] == 'MEDICINE' || data1[i] == 'MEDECINE') {
        i++;
        while (data1[i] != 'RECOMMENDED TEST' && i < data1.length) {
          if (data1[i] == 'RECOMMENDED TEST') break;
          final List<String> med = data1[i].split(', ');
          // print(med);
          final medName = med[0].substring(3);
          final medQuantity = double.parse(med[1].split(' ')[0]);
          final medTiming = med[2].split(' ');
          final medDuration = med[3].split(' for ')[1];
          final type = med[1].split(' ')[1] == 'ml'
              ? MedicineType.syrup
              : MedicineType.pill;
          medicines.add(
            MedicineModel(
              name: medName,
              timing: medTiming,
              duration: medDuration,
              quantity: medQuantity,
              type: type,
            ),
          );
          i++;
          if (i == data1.length) break;
        }
      }
      if (data1[i] == 'RECOMMENDED TEST') {
        i++;
        while (i < data1.length) {
          final test = data1[i].substring(3);
          // Logger().d(test);
          medicines.add(
            MedicineModel(
              name: test,
              type: MedicineType.test,
              quantity: 1,
              timing: ['al'],
            ),
          );
          i++;
        }
      }
    }
    Logger().i(medicines.length);
    Provider.of<MedicineProvider>(context, listen: false)
        .setPrescription(PrescriptionModel(
      diseaseName: diseaseName,
      medicines: medicines,
      note: 'Get well soon',
    ));
    Provider.of<MedicineProvider>(context, listen: false)
        .setCurrMedicine(medicines[0]);
  } catch (e) {
    print('exception on OCR operation: ${e.toString()}');
  }

  imageFile.deleteSync();

  await pref.setBool('hasPris', true);
  await pref.reload();
  hasPris.value = pref.getBool('hasPris');
}
