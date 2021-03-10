// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../common/common_vals.dart';
import '../common/enums.dart';
import '../models/models_no_hive.dart';
import '../providers/prescription_provider.dart';
import '../utils/medical_icons_icons.dart';

Map<MedicineType, IconData> medicineTypeToIcon = {
  MedicineType.pill: MedicalIcons.pill,
  MedicineType.syringe: MedicalIcons.syringe,
  MedicineType.test: MedicalIcons.test_tootls,
  MedicineType.syrup: MedicalIcons.bottle,
};

class Prescription extends StatelessWidget {
  const Prescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prescription = Provider.of<MedicineProvider>(context).getPrescription;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder(
          future: Dio().get(
            fetchLink + '/getprescription',
            // queryParameters: {
            //   'pid': pid,
            // },
          ),
          builder: (
            BuildContext context,
            AsyncSnapshot<Response<dynamic>> snapshot,
          ) {
            if (snapshot.hasData) {
              final data = snapshot.data.data[0];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 30, left: 30),
                    child: AutoSizeText(
                      // data['diagnosedWith'],
                      prescription.diseaseName ?? 'Disease name',
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                      ),
                      maxFontSize: 50,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 30, left: 30),
                    child: AutoSizeText(
                      // data['note'] ?? 'note.',
                      prescription.note ?? 'note.',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                      ),
                      maxFontSize: 30,
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 30, left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Prescription',
                          style: const TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.25,
                          ),
                          maxLines: 1,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            'Approx. Duration:\n${prescription.duration ?? '2 weeks'}',
                            // 'Duration: ${data['duration'] ?? '2 weeks'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        Provider.of<MedicineProvider>(context).currMedicine =
                            MedicineModel(
                          name: data['med1Medname'] ?? data['Med1Medname'],
                          type: data['med1Medtype'] ?? MedicineType.pill,
                          timing: data['med1Frequency'] != null
                              ? data['med1Frequency'].split(' ')
                              : ['bbf', 'bl', 'ad'],
                          duration: data['med1Duration'],
                          quantity: data['med1quantity'],
                          note: data['med1Note'] ?? '',
                        );

                        return PrescriptionItem(
                          medicine: prescription.medicines[index],
                          next: 'Before Lunch',
                        );
                      },
                      itemCount: prescription.medicines.length,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

class PrescriptionItem extends StatelessWidget {
  final MedicineModel medicine;
  final String next;

  const PrescriptionItem({
    Key key,
    this.medicine,
    this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(5, 5),
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  medicine.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              ),
              Builder(
                builder: (context) {
                  final List<Widget> c = [];
                  try {
                    for (var i = 0; i < medicine.timing.length; i++) {
                      c.add(
                        Icon(
                          medicineTypeToIcon[medicine.type],
                        ),
                      );
                      if (i < medicine.quantity - 1)
                        c.add(
                          const SizedBox(width: 5),
                        );
                    }
                    return Row(
                      children: c,
                    );
                  } catch (e) {
                    Logger().e(e);
                    return Container();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                medicine.type == MedicineType.test
                    ? ''
                    : '${medicine.timing.length} time(s) per day\nfor ${medicine.duration}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              // IconButton(
              //   icon: const Icon(
              //     Boxicons.bx_edit_alt,
              //   ),
              //   iconSize: 28,
              //   color: Colors.grey.shade500,
              //   onPressed: () {},
              // ),
              AutoSizeText(
                medicine.type == MedicineType.test
                    ? 'Date: Tomorrow'
                    : 'Next: $next',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
