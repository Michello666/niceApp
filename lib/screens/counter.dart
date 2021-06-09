import 'dart:io';
import 'dart:js';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/auth.dart';
import 'package:task_app/screens/weather_screen.dart';

class Counter extends StatefulWidget {
  // Counter({Key key, @required this.storage}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt("startupNumber");
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> _setInitNumber() async {
    final prefs = await SharedPreferences.getInstance();

    print("##########################################:    $prefs");
    final intFromPrefs = await _getIntFromSharedPref();
    print("##########################################:    $intFromPrefs");
    if (intFromPrefs == null) {
      setState(() {
        _counter = 0;
      });
    } else
      setState(() {
        _counter = intFromPrefs;
      });
      prefs.setInt("startupNumber", _counter);
  }

  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    print("################################################# RESET COUNTER");
    print(prefs.getInt("startupNumber"));
    await prefs.setInt("startupNumber", 0);

    setState(() {
          _counter=0;
        });
  }

  @override
  void initState() {
    super.initState();
    _setInitNumber();
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    print("####################################################: $lastStartupNumber");
    int currentSturtupNumber = ++lastStartupNumber;

    print("##################################:     $currentSturtupNumber");
    await prefs.setInt("startupNumber", currentSturtupNumber);
    setState(() {
      _counter = currentSturtupNumber;
    });
  }

  Future<void> _decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    print("####################################################: $lastStartupNumber");
    int currentStartupNumber = --lastStartupNumber;
    print("####################################################: $currentStartupNumber");
    await prefs.setInt("startupNumber", currentStartupNumber);
    setState(() {
      _counter = currentStartupNumber;
    });
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
  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   // print("######################################### Dir"+directory.path.toString());
  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   // print("#################################### LocalFile ");
  //   final path = await _localPath;
  //   return File("$path/counter.txt");
  // }

  // Future<File> writeCounter(int counter) async {
  //   // print("############################################IN WriteCounter");
  //   final file = await _localFile;
  //   return file.writeAsString("$_counter");
  // }

  // Future<int> readCounter() async {
  //   try {
  //     final file = await _localFile;
  //     final insides = await file.readAsString();
  //     return int.parse(insides);
  //   } catch (e) {
  //     return 0;
  //   }
  // }



  // Future<File> _resetCounter() async {
  //   setState(() {
  //     _counter = 0;
  //   });
  //   return widget.storage.writeCounter(_counter);
  //   // print('############################################ reset');
  // }

// class CounterStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/counter.txt');
//   }

//   Future<int> readCounter() async {
//     try {
//       final file = await _localFile;

//       // Read the file
//       final contents = await file.readAsString();
//       if(contents==null){
//         return 0;
//       }
//       return int.parse(contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return 0;
//     }
//   }

//   Future<File> writeCounter(int counter) async {
//     final file = await _localFile;

//     // Write the file
//     return file.writeAsString('$counter');
//   }
// }

 

