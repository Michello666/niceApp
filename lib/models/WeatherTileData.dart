import 'package:task_app/models/WeatherData.dart';

class WeatherTileData {
  final List list;

  WeatherTileData({this.list});

  factory WeatherTileData.fromJson(Map<String, dynamic> json) {
    List list = [];

    for (dynamic e in json["list"]) {
      WeatherData wd = new WeatherData(
          date: new DateTime.fromMillisecondsSinceEpoch(e["dt"] * 1000,
              isUtc: false),
          main: e["weather"][0]["main"],
          name: json["city"]["name"],
          temp: e["main"]["temp"].toDouble(),
          icon: e["weather"][0]["icon"]);

      list.add(wd);
    }

    return WeatherTileData(list: list);
  }
}
