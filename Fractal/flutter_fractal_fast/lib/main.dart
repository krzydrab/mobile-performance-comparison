import 'dart:async';
import 'dart:typed_data';
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
      duration: Duration(milliseconds: 60000), 
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
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
                      painter: ImagePainter(image: snapshot.data),
                      child: Container(
                        width: this._width,
                        height: this._height,
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

  ImagePainter({this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // NOTE: this function runs almost in zero time because drawing
    // is done on separate thread
    canvas.drawImage(image, Offset.zero, Paint());
    FPSCalculator.update();
    print("FPS: ${FPSCalculator.fps}");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FPSCalculator {
  static Stopwatch stopwatch = Stopwatch();
  static int fps = 0; 

  static void update() {
    if (stopwatch.isRunning) {
      int elapsedTime = (stopwatch..stop()).elapsedMilliseconds;
      fps = 1000 ~/ elapsedTime;
    }
    stopwatch..reset()..start();
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
  double maxRe= 1.0;
  double minIm = -1.2;
  double maxIm = 1.2;

  double reFactor = (maxRe-minRe)/(size.width);
  double imFactor = (maxIm-minIm)/(size.height-1);

  double kRe = 0.353 + kOffset;
  double kIm = 0.288 + kOffset;
  int maxIterations = 30;
  int index = 0;

  for(int y = 0; y < size.height; ++y) {
      // Map image coordinates to c on complex plane
      double cIm = maxIm - y*imFactor;
      double cRe = minRe;

      for(int x = 0; x < size.width; ++x, cRe += reFactor, ++index) {
          // Z[0] = c
          var ZRe = cRe;
          var ZIm = cIm;
          pixels[index] = Color.fromRGBO(255, 255, 255, 1.0).value;

          for(int n = 0; n < maxIterations; ++n) {
              // Z[n+1] = Z[n]^2 + K
              // Z[n]^2 = (Z_re + Z_im*i)^2
              //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
              //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
              var ZRe2 = ZRe * ZRe;
              var ZIm2 = ZIm * ZIm;

              if(ZRe2 + ZIm2 > 4) {                 
                  pixels[index] = Color.fromRGBO(n * 8, 0, 0, 1.0).value;
                  break;
              }

              ZIm = 2*ZRe*ZIm + kIm;
              ZRe = ZRe2 - ZIm2 + kRe;
          }
      }
  }
  stopwatch.stop();
  print("Preparing image: ${stopwatch.elapsedMilliseconds}");

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