import 'package:flutter/material.dart';
import 'package:task_app/models/WeatherData.dart';
import 'package:task_app/models/WeatherTileData.dart';
import 'package:task_app/widgets/weather.dart';
import 'package:task_app/widgets/weather_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeatherScreenState();
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = false;
  WeatherData weatherData;
  WeatherTileData weatherTileData;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wether"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: weatherData != null
                        ? Weather(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(Colors.yellow),
                          )
                        : IconButton(
                            icon: Icon(Icons.refresh),
                            tooltip: "Refresh",
                            onPressed: () => loadWeather(),
                            color: Colors.red,
                          ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 200.0,
                  child: weatherTileData != null
                      ? ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => WeatherTile(
                                weather: weatherTileData.list.elementAt(index),
                              ))
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadWeather() async {
    setState(() {
      isLoading = true;
    });
    final warsawLat = 52.237049;
    final warsawLon = 21.017532;
    final weatherUrl = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?appid=8c756e6d2b3b79a996e502823df8d4ca&lat=${warsawLat.toString()}&lon=${warsawLon.toString()}");
    final weatherTileUrl = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?appid=8c756e6d2b3b79a996e502823df8d4ca&lat=${warsawLat.toString()}&lon=${warsawLon.toString()}");
    final weatherResponse = await http.get(weatherUrl);
    final weatherTileResponse = await http.get(weatherTileUrl);

    if(weatherResponse.statusCode==200 && weatherTileResponse.statusCode==200){
      return setState((){
        weatherData= WeatherData.fromJson(jsonDecode(weatherResponse.body));
        weatherTileData= WeatherTileData.fromJson(jsonDecode(weatherTileResponse.body));
        isLoading=false;
      });
    }
  }
}
