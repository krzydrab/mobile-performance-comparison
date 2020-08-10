import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Select Sort',
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

class _MyHomePageState extends State<MyHomePage> {
  static const int NB_OF_ELEMENTS = 10000;
  TextEditingController _controller;

  List<double> generateRandomList() {
    var random = new Random();
    List<double> res = List(NB_OF_ELEMENTS);
    for (var i = 0; i < _MyHomePageState.NB_OF_ELEMENTS; i++) {
      res[i] = random.nextDouble();
    }
    return res;
  }

  void selectSort(List<double> list) {
    for(int i = 0; i < list.length - 1; i++) {
        int minElPos = i;
        for(int j = minElPos + 1; j < list.length; j++) {
            if(list[j] < list[minElPos]) {
                minElPos = j;
            }
        }
        // swap
        double temp = list[i];
        list[i] = list[minElPos];
        list[minElPos] = temp;
    }
  }

  int _time = 0;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _measureTime() {
    var list = generateRandomList();
    final stopwatch = Stopwatch()..start();
    selectSort(list);
    stopwatch.stop();
    setState(() {
      _time = stopwatch.elapsedMilliseconds;
    });
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
            Text(
              'Time: ${_time / 1000.0}',
            ),
            TextField(
              controller: _controller,
            ),
            FlatButton(
              child: Text('Start'), 
              onPressed: _measureTime,
            ),
          ],
        ),
      ),
    );
  }
}
