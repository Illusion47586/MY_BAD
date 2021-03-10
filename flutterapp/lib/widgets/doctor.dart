// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

// Project imports:
import 'package:medico/providers/prescription_provider.dart';
import '../common/common_vals.dart';
import '../screens/qr_scan_screen.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: ValueListenableBuilder(
        valueListenable: hasDoctorDetails,
        builder: (context, value, child) {
          switch (value) {
            case true:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ExtendedImage.network(
                    Provider.of<MedicineProvider>(context).getDoctor.imageLink,
                    fit: BoxFit.cover,
                    width: 180,
                    height: 180,
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
                  const SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    Provider.of<MedicineProvider>(context).getDoctor.name,
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                    maxFontSize: 50,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      launch('tel:8800223291');
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'Call',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      const link = WhatsAppUnilink(
                        phoneNumber: '8800223291',
                      );
                      launch('$link');
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'WhatsApp',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              );
              break;
            default:
              return InkWell(
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRScan(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    'Scan QR',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
