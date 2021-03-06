import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async => runApp(MaterialApp(home: Fractal()));

/// Improved performance by using following trick:
/// [https://itnext.io/procedural-textures-with-flutter-efcf546cd1fc](link)

class Fractal extends StatefulWidget {
  Fractal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FractalState createState() => _FractalState();
}

class _FractalState extends State<Fractal> with SingleTickerProviderStateMixin {
  // ====== Test parameters ======
  double _width = 300;
  double _height = 300;
  int singleTestDuration = 20; // in sec
  // =============================
  double _kOffset = 10000;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: singleTestDuration * 1000), 
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 10.0).animate(controller)
      ..addListener(() {        
        setState(() {
          _kOffset = animation.value;
          Statistics.update();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("Average fps: ${Statistics.totalFrames.toDouble() / singleTestDuration}");
          print("Average calculating time: ${Statistics.totalCalculatingTime / Statistics.totalFrames}");
        }
      });
    controller.forward();
  }

  /// Waits till [ui.Image] is generated and renders
  /// it using [CustomPaint] to render it.
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Julia fractal - fast version"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${this._kOffset}"),
            SizedBox(
              child: FutureBuilder<ui.Image>(
                future: generateImage(Size(this._width, this._height), this._kOffset),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomPaint(
                      // Passing our image
                      painter: ImagePainter(
                        image: snapshot.data, 
                        width: screenWidth, 
                        height: screenHeight - 117,
                      ),
                      child: Container(
                        width: screenWidth,
                        height: screenHeight - 117,
                      ),
                    );
                  }
                  return Text('Generating image...');
                },
              )
            )
          ],
        ),
      ),
    );
  }
}


/// Paints given [ui.Image] on [ui.Canvas]
class ImagePainter extends CustomPainter {
  ui.Image image;
  double width;
  double height;

  ImagePainter({this.image, this.width, this.height});

  @override
  void paint(Canvas canvas, Size size) {
    // NOTE: this function runs almost in zero time because drawing
    // is done on separate thread
    // canvas.drawImage(image, Offset.zero, Paint());
    canvas.drawImageRect(
      image, 
      Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble()), 
      Rect.fromLTRB(0, 0, width, height),
      Paint()
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Statistics {
  static Stopwatch stopwatch = Stopwatch();
  static int frames = 0;
  static int totalFrames = 0;
  static int calculatingTime = 0;
  static int totalCalculatingTime = 0;

  static void update() {
    if (stopwatch.isRunning) {
      int elapsedTime = stopwatch.elapsedMilliseconds;
      if(elapsedTime > 1000) {
        totalFrames += frames;
        totalCalculatingTime += calculatingTime;
        print("FPS: $frames, Calculating time: $calculatingTime");
        frames = 0;
        calculatingTime = 0;
        stopwatch..reset()..start();
      }
      frames += 1;
    } else {
      stopwatch..reset()..start();
    }
  }
}

/// Generates an [ui.Image] with certain pixel data
Future<ui.Image> generateImage(Size size, double kOffset) async {
  final stopwatch = Stopwatch()..start();    
  int width = size.width.ceil();
  int height = size.height.ceil();
  var completer = Completer<ui.Image>();

  Int32List pixels = Int32List(width * height);

  double minRe = -2.0;
  double maxRe= 2.0;
  double minIm = -1.5;
  double maxIm = 1.5;

  double reFactor = (maxRe-minRe)/(size.width);
  double imFactor = (maxIm-minIm)/(size.height-1);

  double kRe = 0.0 + sin(kOffset) * 0.4;
  double kIm = -0.5 + cos(kOffset) * 0.4;
  int maxIterations = 30;
  int index = 0;
  int blackColor = Color.fromRGBO(0, 0, 0, 1.0).value;

  for(int y = 0; y < size.height; ++y) {
      // Map image coordinates to c on complex plane
      double cIm = maxIm - y*imFactor;
      double cRe = minRe;

      for(int x = 0; x < size.width; ++x, cRe += reFactor, ++index) {
          // Z[0] = c
          var ZRe = cRe;
          var ZIm = cIm;
          pixels[index] = blackColor;

          for(int n = 0; n < maxIterations; ++n) {
              // Z[n+1] = Z[n]^2 + K
              // Z[n]^2 = (Z_re + Z_im*i)^2
              //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
              //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
              var ZRe2 = ZRe * ZRe;
              var ZIm2 = ZIm * ZIm;

              if(ZRe2 + ZIm2 > 4) {                 
                  pixels[index] = blackColor | min(60 + n * 10, 255) << 16;
                  break;
              }

              ZIm = 2*ZRe*ZIm + kIm;
              ZRe = ZRe2 - ZIm2 + kRe;
          }
      }
  }
  ui.decodeImageFromPixels(
    pixels.buffer.asUint8List(),
    width,
    height,
    ui.PixelFormat.bgra8888,
    (ui.Image img) {
      completer.complete(img);
    },
  );

  stopwatch.stop();
  Statistics.calculatingTime += stopwatch.elapsedMilliseconds;

  return completer.future;
}
