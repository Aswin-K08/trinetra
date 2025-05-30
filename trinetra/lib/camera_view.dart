import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:trinetraflutter/homePage.dart';
import 'package:trinetraflutter/main.dart';
import 'package:trinetraflutter/values.dart';

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.customPaint,
      required this.onImage,
      this.initialDirection = CameraLensDirection.front})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  int _cameraIndex = 1;
  bool stream = false;

  @override
  void initState() {
    super.initState();
    stream = false;
    try {
      _startLiveFeed();
    } catch (e) {}
  }

  @override
  void dispose() async {
    super.dispose();
    print("Before Dispose:$_controller");
    if (stream) {
      await _controller?.stopImageStream();
    }
    await _controller?.dispose();
    _controller = null;
    print("After Dispose:$_controller");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _liveFeedBody(),
            Container(
              alignment: Alignment.center,
              color: align ? Colors.green : Colors.deepPurple.shade300,
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  counter.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "font2",
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height - 70,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_controller!),
          if (widget.customPaint != null) widget.customPaint!,
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = cameras![_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
      enableAudio: false,
    );
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _controller!.startImageStream(_processCameraImage).catchError((e) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
        stream != stream;
      });
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras![_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.yuv420;



    final inputImageData = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation,
      format: InputImageFormat.nv21,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, metadata: inputImageData);

    widget.onImage(inputImage);
  }
}
