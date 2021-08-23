import 'dart:typed_data';
import 'dart:ui';
import 'package:admin_kg1/second.dart';
import 'package:flutter/material.dart';
// import 'package:mnistdigitrecognizer/utils/constants.dart';
import 'package:tflite/tflite.dart';

final _canvasCullRect = Rect.fromPoints(
  Offset(0, 0),
  Offset(Constants.imageSize, Constants.imageSize),
);

final _whitePaint = Paint()
  ..strokeCap = StrokeCap.round
  ..color = Colors.white
  ..strokeWidth = Constants.strokeWidth;

final _bgPaint = Paint()..color = Colors.black;

class Recognizer {
  //Recognizer(this.subject);
  int size;

  Future loadModel(String subject) {
    print("الماااااااااااااااااااااااااااااااددددددددددددددددددددددددة");

    Tflite.close();
    print("الماااااااااااااااااااااااااااااااددددددددددددددددددددددددة");
    print(subject);
    if (subject == "رياضيات") {
      size = Constants.mnistImageSize;
      return Tflite.loadModel(
        model: "assets/mnistN.tflite",
        labels: "assets/mnistN.txt",
      );
    } else if (subject == "عربي") {
      size = 32;
      return Tflite.loadModel(
        model: "assets/mnistA.tflite",
        labels: "assets/mnistA.txt",
      );
    } else {
      size = Constants.mnistImageSize;
      return Tflite.loadModel(
        model: "assets/mnistE.tflite",
        labels: "assets/mnistE.txt",
      );
    }
  }

  dispose() {
    Tflite.close();
  }

  Future<Uint8List> previewImage(List<Offset> points) async {
    final picture = _pointsToPicture(points);
    final image = await picture.toImage(
        Constants.mnistImageSize, Constants.mnistImageSize);
    var pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes.buffer.asUint8List();
  }

  Future recognize(List<Offset> points) async {
    final picture = _pointsToPicture(points);
    Uint8List bytes = await _imageToByteListUint8(picture, size);
    return _predict(bytes);
  }

  Future _predict(Uint8List bytes) {
    return Tflite.runModelOnBinary(binary: bytes);
  }

  Future<Uint8List> _imageToByteListUint8(Picture pic, int size) async {
    final img = await pic.toImage(size, size);
    final imgBytes = await img.toByteData();
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);

    int index = 0;

    for (int i = 0; i < imgBytes.lengthInBytes; i += 4) {
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }

    return resultBytes.buffer.asUint8List();
  }

  Picture _pointsToPicture(List<Offset> points) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, _canvasCullRect)
      ..scale(Constants.mnistImageSize / Constants.canvasSize);

    canvas.drawRect(
        Rect.fromLTWH(0, 0, Constants.imageSize, Constants.imageSize),
        _bgPaint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], _whitePaint);
      }
    }

    return recorder.endRecording();
  }
}
