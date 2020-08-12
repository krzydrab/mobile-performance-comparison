import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';

void main() => runApp(MyApp());

// NOTE: Improving performance: https://itnext.io/procedural-textures-with-flutter-efcf546cd1fc

class MyApp extends StatelessWidget {
  // Check if app with Material widget is slower or not
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fractal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Fractal(title: 'Flutter Demo Home Page'),
    );
  }
}

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
      duration: Duration(milliseconds: 20000), 
      vsync: this,
    );

    // Uncomment to enable cyclic animation
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reset();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    animation = Tween(begin: 0.0, end: 0.2).animate(controller)
      ..addListener(() {        
        setState(() {
          _kOffset = animation.value;
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Julia fractal"),
      ),
      body: Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: new CustomPaint(
                painter: new JuliaPainter(this._kOffset),
              ),
              width: this._width,
              height: this._height,
            )
          ],
        ),
      ),
    );
  }
}

class JuliaPainter extends CustomPainter {
  double kOffset = 0;

  JuliaPainter(double kOffset) {
    this.kOffset = kOffset;    
  }

  @override
  void paint(Canvas canvas, Size size) {
    final stopwatch = Stopwatch()..start();    

    double minRe = -2.0;
    double maxRe= 1.0;
    double minIm = -1.2;
    double maxIm = 1.2;

    double reFactor = (maxRe-minRe)/(size.width);
    double imFactor = (maxIm-minIm)/(size.height-1);

    double kRe = 0.353 + kOffset;
    double kIm = 0.288 + kOffset;
    int maxIterations = 30;
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1         
      ..isAntiAlias = false;

    for(int y = 0; y < size.height; ++y) {
        // Map image coordinates to c on complex plane
        double cIm = maxIm - y*imFactor;
        double cRe = minRe;

        for(int x = 0; x < size.width; ++x, cRe += reFactor) {
            // Z[0] = c
            var ZRe = cRe;
            var ZIm = cIm;

            // Set default color
            var point = new Offset(x.toDouble(), y.toDouble());
            paint.color = Colors.black;
            
            // Change to drawRawPoints
            canvas.drawPoints(PointMode.points, [point], paint);

            for(int n = 0; n < maxIterations; ++n) {
                // Z[n+1] = Z[n]^2 + K
                // Z[n]^2 = (Z_re + Z_im*i)^2
                //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
                //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
                var ZRe2 = ZRe * ZRe;
                var ZIm2 = ZIm * ZIm;

                if(ZRe2 + ZIm2 > 4) {                 
                    paint.color = Color.fromARGB(255, n * 8, 0, 0);
                    break;
                }

                ZIm = 2*ZRe*ZIm + kIm;
                ZRe = ZRe2 - ZIm2 + kRe;
            }

            canvas.drawPoints(PointMode.points, [point], paint);
        }
    }
    stopwatch.stop();
    print("Rendering time: ${stopwatch.elapsedMilliseconds}");
  }

  @override
  bool shouldRepaint(JuliaPainter oldDelegate) {
    return oldDelegate.kOffset != this.kOffset;
  }
}