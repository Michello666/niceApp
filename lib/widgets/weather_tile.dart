import 'package:flutter/material.dart';
import 'package:task_app/models/WeatherData.dart';
import 'package:task_app/models/WeatherTileData.dart';
import 'package:intl/intl.dart';

class WeatherTile extends StatelessWidget {
  final WeatherData weather;

  WeatherTile({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.name,
              style: TextStyle(color: Colors.yellow),
            ),
            Text(
              weather.main,
              style: TextStyle(color: Colors.yellow, fontSize: 32.0),
            ),
            Text(
              "${(((((5*(weather.temp-32))/9)*100).round())/100).toString()} °C",
              style: TextStyle(color: Colors.yellow),
            ),
            // AssetImage("assets\wetherIcons\sunny.png"),
            Image.network('https://openweathermap.org/img/w/${weather.icon}.png')
              
              // height: 15.0,
              // width: 15.0,
            ,
            Text(
              DateFormat.yMMMd().format(weather.date),
              style: TextStyle(color: Colors.yellow),
            ),
            Text(
              DateFormat.Hm().format(weather.date),
              style: TextStyle(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
