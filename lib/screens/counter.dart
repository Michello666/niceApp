import 'dart:io';


import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/auth.dart';
import 'package:task_app/screens/weather_screen.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // print("######################################### Dir"+directory.path.toString());
    return directory.path;
  }

  Future<File> get _localFile async {
    // print("#################################### LocalFile ");
    final path = await _localPath;
    return File("$path/counter.txt");
  }

  Future<File> writeCounter(int counter) async {
    // print("############################################IN WriteCounter");
    final file = await _localFile;
    return file.writeAsString("$_counter");
  }

  Future<int> readCounter() async{
    try{
      final file= await _localFile;
      final insides= await file.readAsString();
      return int.parse(insides);
    }catch(e){
      return 0;
    }
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await writeCounter(_counter);
    // print('############################################ incrementing');
  }

  void _decrementCounter() async {
    setState(() {
      _counter--;
    });
    await writeCounter(_counter);
    // print('############################################ decrementing');
  }

  void _resetCounter() async {
    setState(() {
      _counter = 0;
    });
    await writeCounter(_counter);
    // print('############################################ reset');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Counter"),
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: "Logout",
              color: Colors.red,
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logOut();
              },
            )
          ],
        ),
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
