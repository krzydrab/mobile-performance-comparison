import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
      }
      frames += 1;
    } else {
      stopwatch..reset()..start();
    }
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  bool _updateTrigger = false;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 60000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {
          _updateTrigger = !_updateTrigger;
        });
        FPSCalculator.update();
        print(FPSCalculator.fps);
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var width = (screenWidth * 0.8).toInt();
    var height = (screenHeight * 0.8).toInt();

    return Scaffold(
      body: CustomPaint(
        painter: ShapesPainter(_updateTrigger, screenWidth * 0.1, screenWidth * 0.1, width, height),
      ),
    );
  }
}

enum Mode { 
  ovals, 
  rects, 
}

class ShapesPainter extends CustomPainter {
  Mode mode = Mode.ovals;
  int numberOfShapes = 1000;

  bool updateTrigger;
  double ovalSize;
  double rectSize;
  int width;
  int height;
  var rng = new Random();
  var gradient;
  Paint strokePaint;
  Paint gradientPaint;

  ShapesPainter(this.updateTrigger, this.ovalSize, this.rectSize, this.width, this.height) {
    var yellow = Color.fromARGB(30, 255, 255, 0);
    var red = Color.fromARGB(100, 255, 0, 0);
    gradient = ui.Gradient.radial(
      Offset(0, 0),
      ovalSize * 0.5,
      [red, yellow],
      null,
      TileMode.repeated,
      null
    );
    gradientPaint = Paint()..shader = gradient;
    strokePaint = Paint()..style = PaintingStyle.stroke;
  }

  void drawOvals(Canvas canvas, Size size) {
    for(int i = 0; i < numberOfShapes ; i++) {
      double left = rng.nextInt(width).toDouble();
      double top = rng.nextInt(height).toDouble();
      canvas.save();
      canvas.translate(left, top);
      canvas.drawCircle(Offset(0, 0), ovalSize * 0.5, gradientPaint);
      canvas.restore();
    }
  }

  void drawRects(Canvas canvas, Size size) {
    for(int i = 0; i < numberOfShapes ; i++) {
      double left = rng.nextInt(width).toDouble();
      double top = rng.nextInt(height).toDouble();
      canvas.save();
      canvas.translate(left, top);
      canvas.rotate(rng.nextDouble() * 3.14);
      canvas.drawRect(Rect.fromPoints(Offset(0, 0), Offset(rectSize, rectSize)), strokePaint);
      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(mode == Mode.ovals) {
      drawOvals(canvas, size);
    } else if(mode == Mode.rects) {
      drawRects(canvas, size);
    }
  }

  bool shouldRepaint(ShapesPainter oldDelegate) {
    return oldDelegate.updateTrigger != this.updateTrigger;
  }
}