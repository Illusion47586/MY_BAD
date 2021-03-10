// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:medico/common/enums.dart';
import 'package:medico/models/models_no_hive.dart';
import 'package:medico/providers/prescription_provider.dart';
import 'package:medico/widgets/prescription.dart';

class Medicine extends StatelessWidget {
  MedicineModel medicine;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        medicine = Provider.of<MedicineProvider>(context).getCurrMedicine;
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 400,
              width: min(MediaQuery.of(context).size.width - 40, 300),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: const Offset(5, 5),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Aspirin',
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                        height: 1.05,
                      ),
                      maxLines: 1,
                      wrapWords: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: AutoSizeText(
                        medicine.note == '' ? 'Ecosprin 150mg' : medicine.note,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.25,
                          height: 1.05,
                        ),
                        maxLines: 1,
                        wrapWords: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    AutoSizeText(
                      '${1} ${medicine.type == MedicineType.pill ? 'tablet(s)' : 'ml'}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                        height: 1.05,
                      ),
                      maxLines: 1,
                      wrapWords: true,
                    ),
                    const SizedBox(height: 20),
                    AutoSizeText(
                      'Before Lunch',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                        height: 1.05,
                      ),
                      maxLines: 1,
                      wrapWords: true,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  medicineTypeToIcon[medicine.type],
                  size: 30,
                  semanticLabel: 'pill',
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: IconButton(
                icon: const Icon(Boxicons.bxAlarm),
                iconSize: 30,
                splashRadius: 30,
                hoverColor: Colors.grey[700],
                splashColor: Colors.grey.shade200,
                focusColor: Colors.grey.shade200,
                tooltip: 'edit',
                onPressed: () {
                  Logger().d('Alarm');
                },
              ),
            ),
            Positioned(
              bottom: -100,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3 days left',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
