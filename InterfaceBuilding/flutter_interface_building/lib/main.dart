import 'package:flutter/material.dart';
import 'row_data.dart';
import 'tester.dart';
import 'visibility_change_tester.dart';
import 'swap_tester.dart';
import 'full_rebuild_tester.dart';
import 'no_change_tester.dart';

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

enum TestType { Visibility, Swap, FullRebuild, NoChange }
enum ComponentType { Text, Button }

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin  {
  // ====== Test parameters ======
  TestType _testType = TestType.Swap;
  ComponentType _componentType = ComponentType.Button;
  int singleTestDuration = 10; // in sec
  // =============================

  int frames = 0;
  bool _showResults = false;
  List<RowData> _rows = [];
  Tester _tester;
  void Function() noOpFn = () {};

  Animation<double> animation;
  AnimationController controller;

  void setupTester() {
    switch(_testType) {
      case TestType.Visibility:
        this._tester = VisibilityChangeTester();
        break;
      case TestType.Swap:
        this._tester = SwapTester();
        break;
      case TestType.FullRebuild:
        this._tester = FullRebuildTester();
        break;
      case TestType.NoChange:
        this._tester = NoChangeTester();
    }
  }

  @override
  void initState() {
    super.initState();
    this.setupTester();
    controller = AnimationController(
      duration: Duration(milliseconds: this.singleTestDuration * 1000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {
        setState(() {
          this._rows = this._tester.updateRows();
        });
        this.frames += 1;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (this._tester.isCompleted()) {
            this._tester.testEnded(this.frames / this.singleTestDuration);
            this._showResults = true;
          } else {
            this._tester.testEnded(this.frames / this.singleTestDuration);
            this.frames = 0;
            this._rows = this._tester.nextTest();
            controller.reset();
            controller.forward();
          }
        }
      });
    this._rows = this._tester.nextTest();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
            _showResults
              ? _tester.results.map((r) => Text("N: ${r.n}, FPS: ${r.fps}, TTM: ${r.timeToModify}")).toList()
              : this._componentType == ComponentType.Text 
                ? _rows.map((e) => Text("Row: ${e.value}")).toList()
                : _rows.map((e) => FlatButton(child: Text("Row: ${e.value}"), onPressed: this.noOpFn)).toList(),
        ),
      ),
    );
  }
}
