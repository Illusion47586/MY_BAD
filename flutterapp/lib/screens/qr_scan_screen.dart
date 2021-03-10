// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

// Project imports:
import 'package:medico/models/models_no_hive.dart';
import 'package:medico/providers/prescription_provider.dart';
import '../common/common_vals.dart';
import '../helper/base64.dart';

// import 'package:medico/models/doctor_model.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderRadius: 20,
                borderWidth: 5,
              ),
              key: qrKey,
              onQRViewCreated: (controller) =>
                  {_onQRViewCreated(controller, context)},
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Align the QR code\ninside the corners',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
        docres = scanData;
        final Map<String, dynamic> doc = jsonDecode(scanData.code);
        // final img = await base64ToImage(doc['image'], doc['name']);
        print(doc['name']);
        final doctorModel = DoctorModel(
          name: doc['name'],
          contact: doc['contact'].toString(),
          imageLink:
              'https://pyxis.nymag.com/v1/imgs/288/3b0/e54e4bfd4095f34eca92495317353abcb8-23-doctor-strange.rsquare.w700.jpg',
        );
        Provider.of<MedicineProvider>(context, listen: false).myDoc =
            doctorModel;
        // final docBox = await Hive.openBox('DoctorModel');
        // docBox.add(doctorModel);
        await controller.stopCamera();
        hasDoctorDetails.value = true;
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(
            duration: 200,
          );
        }
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
