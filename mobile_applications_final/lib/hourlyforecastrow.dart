import 'package:flutter/material.dart';
import 'package:mobile_applications_final/main.dart';

class HourlyForecastRow extends StatefulWidget {
  final HourlyForecast hourlyForecast;
  const HourlyForecastRow(this.hourlyForecast, {super.key});

  @override
  State<HourlyForecastRow> createState() => _HourlyForecastRowState();
}

class _HourlyForecastRowState extends State<HourlyForecastRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(GetProperTime(widget.hourlyForecast.startTime.substring(11, 13)), style: TextStyle(color: Colors.white)),
        Text(widget.hourlyForecast.temperature.toString() + widget.hourlyForecast.temperatureUnit, style: TextStyle(color: Colors.white)),
        Text(widget.hourlyForecast.windSpeed + widget.hourlyForecast.windDirection, style: TextStyle(color: Colors.white)),
        Text(widget.hourlyForecast.probabilityOfPrecipitation["value"].toString() + "%", style: TextStyle(color: Colors.white)),
        Image.network(widget.hourlyForecast.icon)
      ],
    );
  }

  String GetProperTime(String timeAsString) {
    int timeAsInt = int.parse(timeAsString);
    bool isPM = timeAsInt >= 12;
    timeAsInt %= 12;
    if (timeAsInt == 0) {
      timeAsInt = 12;
    }
    if (isPM) {
      return timeAsInt.toString() + "PM";
    }
    return timeAsInt.toString() + "AM";
  }
}