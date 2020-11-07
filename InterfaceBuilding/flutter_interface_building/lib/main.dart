import 'package:flutter/material.dart';
import 'dart:math';

import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interface building',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key); 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class RowData {
  int id;
  double value;
  bool visibility = true;

  RowData() {
    var rng = new Random();
    this.id = rng.nextInt(10000);
    this.value = rng.nextDouble();
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
      }
      frames += 1;
    } else {
      stopwatch..reset()..start();
    }
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {
  List<RowData> _rows = new List(100).map((e) => RowData()).toList();

  Animation<double> animation;
  AnimationController controller;

  void _randomVisiblityChange() {
    var rng = new Random();
    int itemsToChange = 2;

    while(itemsToChange > 0) {
      int pos = rng.nextInt(this._rows.length);
      this._rows[pos].visibility = !this._rows[pos].visibility;
      itemsToChange -= 1;
    }
  }

  // void randomElementsSwap() {
  //       var itemsToChange = 10;
  //       while(itemsToChange > 0) {
  //           let i = Int.random(in: 0..<self.rows.count);
  //           let j = Int.random(in: 0..<self.rows.count);
  //           rows.swapAt(i, j);
  //           itemsToChange -= 1;
  //       }
  //   }

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
          this._randomVisiblityChange();
        });
        FPSCalculator.update();
        print(FPSCalculator.fps);
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
            _rows.where((e) => e.visibility).map((e) => Text("Row: ${e.value}")).toList(),
        ),
      ),
    );
  }
}
