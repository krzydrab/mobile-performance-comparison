import 'package:flutter/material.dart';
import 'package:flutter_algorithms/testers/ackermann_function_tester.dart';
import 'package:flutter_algorithms/testers/gauss_elimination_tester.dart';
import 'package:flutter_algorithms/testers/select_sort_tester.dart';
import 'package:flutter_algorithms/testers/algorithm_tester.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Algorithms test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Algorithm { AckermannFunction, GaussElimination, SelectSort }

class _MyHomePageState extends State<MyHomePage> {
  Algorithm _algorithm = Algorithm.AckermannFunction;
  String _result = "Run algorithm to measure time.";

  void _startBtnClicked() {
    print("startClicked");
    AlgorithmTester tester = buildTester();
    List<Result> results = tester.testAll(0, 8);
    setState(() {
      _result = results.map((r) => "${r.description} : ${r.time / 1000.0} s").join("\n");
    });
  }

  AlgorithmTester buildTester() {
    switch(_algorithm) {
      case Algorithm.AckermannFunction:
        return AckermannFunctionTester();
      case Algorithm.GaussElimination:
        return GaussEliminationTester();
      case Algorithm.SelectSort:
        return SelectSortTester();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_result,),
            DropdownButton<Algorithm>(
              value: _algorithm,
              items: Algorithm.values.map((Algorithm value) {
                return DropdownMenuItem<Algorithm>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (Algorithm value) {
                setState(() {
                  _algorithm = value;
                });
              },
            ),
            FlatButton(
              child: Text('Start'), 
              onPressed: _startBtnClicked,
            ),
          ],
        ),
      ),
    );
  }
}
