import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/auth.dart';
import 'package:task_app/screens/my_auth_screen.dart';
import 'package:task_app/screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      child: MaterialApp(
      title: "Supp App",
      theme: ThemeData(
        backgroundColor: Colors.deepPurple[200],
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyAuthPage()
    ),
    );
  }
}
