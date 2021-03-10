// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:medico/common/common_vals.dart';
import 'package:medico/models/models_no_hive.dart';

// import '../models/patient_model.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: FutureBuilder(
            // future: Hive.openBox('PatientModel'),
            future: Dio().get(fetchLink + '/allusers'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // final Box<PatientModel> b = snapshot.data;
                final user = snapshot.data.data[0];
                try {
                  return PatientProfile(
                    patient: PatientModel(
                      name: user['name'],
                      contact: user['email'],
                      age: user['age'] ?? 32,
                      gender: user['gender'] ?? 0,
                      height: user['height'] ?? 170,
                      weight: user['weight'] ?? 68,
                      occupation: user['occupation'] ?? 'Lawyer',
                      imageLink: 'https://loremflickr.com/512/512/beach',
                    ),
                  );
                } catch (e) {
                  return const Text('error');
                }
              }

              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}

class PatientProfile extends StatelessWidget {
  final PatientModel patient;
  const PatientProfile({
    Key key,
    this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtendedImage.network(
          patient.imageLink,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          cache: true,
          shape: BoxShape.circle,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case LoadState.failed:
                return const Center(
                  child: Icon(
                    Boxicons.bxX,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                );
                break;
              case LoadState.completed:
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                );
                break;
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
        const SizedBox(height: 20),
        AutoSizeText(
          patient.name,
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w700,
          ),
          maxFontSize: 50,
          maxLines: 1,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const AutoSizeText(
              'Age:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              patient.age.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const AutoSizeText(
              'Sex:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              patient.gender == 0 ? 'Male' : 'Female',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const AutoSizeText(
              'Height:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              '${patient.height}cm',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const AutoSizeText(
              'Weight:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              '${patient.weight}kg',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const AutoSizeText(
              'Occupation:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            AutoSizeText(
              patient.occupation,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ],
        ),
        const SizedBox(height: 15),
        const AutoSizeText(
          'Contact:',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        AutoSizeText(
          patient.contact,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
