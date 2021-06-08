import 'package:flutter/material.dart';
import 'package:task_app/models/WeatherData.dart';
import 'package:intl/intl.dart';

class Weather extends StatelessWidget {
final WeatherData weather;

Weather({Key key, @required this.weather}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Image.network('https://openweathermap.org/img/w/${weather.icon}.png')
          // height: 25.0,
          // width: 25.0,
        ),
      Text(
        DateFormat.yMMMd().format(weather.date),
        style: TextStyle(color: Colors.yellow),
      ),
      Text(
        DateFormat.Hm().format(weather.date),
        style: TextStyle(color: Colors.yellow),
      )
    ]);
    
  }
}
