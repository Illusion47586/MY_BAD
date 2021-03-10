// Dart imports:
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_crop_widget/image_crop_widget.dart';

// Project imports:
import '../helper/ocr.dart';

class CropScreen extends StatefulWidget {
  final Uint8List bytes;
  CropScreen(this.bytes);
  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final key = GlobalKey<ImageCropState>();

  Future<ui.Image> getImage() async {
    final codec = await ui.instantiateImageCodec(widget.bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void _onCropPress() async {
    final croppedImage = await key.currentState.cropImage();
    await ocrHelper(croppedImage, context);
    Navigator.pop(context);

    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) => RawImage(
    //     image: croppedImage,
    //     fit: BoxFit.contain,
    //     height: croppedImage.height.toDouble(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: getImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return ImageCrop(key: key, image: snapshot.data);
                    else
                      return const SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      );
                  },
                ),
              ),
            ),
            TextButton(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                child: const Center(
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              onPressed: _onCropPress,
            ),
          ],
        ),
      ),
    );
  }
}
