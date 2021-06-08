import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_app/screens/weather_screen.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter;

  Future<String> getFilePath() async {
    String filePath = "lib\\counter_lib\\counterState.txt";
    return filePath;
  }

  void saveFile() async {
    File file = File(await getFilePath());
    print("saving to file: " + file.readAsStringSync());
    file.writeAsString("$_counter");
  }

  void setCounterValuefromFile() async {
    File file = File(await getFilePath());
    print("setting counter from file: " + file.readAsStringSync());
    int counterValue = int.parse(await file.readAsString());
    this._counter = counterValue;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      saveFile();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      saveFile();
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      saveFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Counter"),
      ),
      body: Center(
        // alignment: Alignment.center,
        // width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "The counter:",
                  ),
                  Text(
                    "$_counter",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: _incrementCounter,
                          child: Icon(Icons.arrow_drop_up)),
                      ElevatedButton(
                        onPressed: _resetCounter,
                        child: Text("Reset"),
                      ),
                      ElevatedButton(
                          onPressed: _decrementCounter,
                          child: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherScreen()));
                  },
                  child: Text(
                    "Check out our weather app!",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
