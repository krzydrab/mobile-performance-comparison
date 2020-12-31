// int version
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
  double _width = 300;
  double _height = 300;
  double _kOffset = 10000;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 15000), 
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 10.0).animate(controller)
      ..addListener(() {        
        setState(() {
          _kOffset = animation.value;
        });
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
    FPSCalculator.update();
    // print("FPS: ${FPSCalculator.fps}");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FPSCalculator {
  static Stopwatch stopwatch = Stopwatch();
  static int frames = 0;
  static int fps = 0;

  static void update() {
    if (stopwatch.isRunning) {
      int elapsedTime = stopwatch.elapsedMilliseconds;
      if(elapsedTime > 1000) {
        fps = frames;
        frames = 0;
        stopwatch..reset()..start();
        print("FPS: $fps");
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

  int minRe = -2000;
  int maxRe= 2000;
  int minIm = -1500;
  int maxIm = 1500;

  int reFactor = ((maxRe-minRe)~/(size.width));
  int imFactor = (maxIm-minIm)~/(size.height-1);

  int kRe = sin(kOffset) * 400 ~/ 1;
  int kIm = -500 + cos(kOffset) * 400 ~/ 1;
  int maxIterations = 30;
  int index = 0;
  int blackColor = Color.fromRGBO(0, 0, 0, 1.0).value;

  for(int y = 0; y < size.height; ++y) {
      // Map image coordinates to c on complex plane
      int cIm = maxIm - y*imFactor;
      int cRe = minRe;

      for(int x = 0; x < size.width; ++x, cRe += reFactor, ++index) {
          // Z[0] = c
          int ZRe = cRe;
          int ZIm = cIm;
          pixels[index] = blackColor;

          for(int n = 0; n < maxIterations; ++n) {
              // Z[n+1] = Z[n]^2 + K
              // Z[n]^2 = (Z_re + Z_im*i)^2
              //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
              //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
              int ZRe2 = ZRe * ZRe;
              int ZIm2 = ZIm * ZIm;

              if(ZRe2 + ZIm2 > 4000000) {                 
                  pixels[index] = blackColor | min(60 + n * 10, 255) << 16;
                  break;
              }

              ZIm = 2*(ZRe*ZIm >> 10) + kIm;
              ZRe = ((ZRe2 - ZIm2) >> 10) + kRe;
          }
      }
  }
  stopwatch.stop();
  //print("Preparing image: ${stopwatch.elapsedMilliseconds}");

  ui.decodeImageFromPixels(
    pixels.buffer.asUint8List(),
    width,
    height,
    ui.PixelFormat.bgra8888,
    (ui.Image img) {
      completer.complete(img);
    },
  );

  return completer.future;
}
