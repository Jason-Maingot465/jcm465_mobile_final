import 'package:flutter/material.dart';
import 'package:mobile_applications_final/main.dart';

class WeeklyForecastRow extends StatefulWidget {
  final WeeklyForecast weeklyForecast;
  const WeeklyForecastRow(this.weeklyForecast, {super.key});

  @override
  State<WeeklyForecastRow> createState() => _WeeklyForecastRowState();
}

class _WeeklyForecastRowState extends State<WeeklyForecastRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(GetProperDay(widget.weeklyForecast.name), style: TextStyle(color: Colors.white)),
        Text(widget.weeklyForecast.temperature.toString() + widget.weeklyForecast.temperatureUnit, style: TextStyle(color: Colors.white)),
        Text(widget.weeklyForecast.windSpeed + widget.weeklyForecast.windDirection, style: TextStyle(color: Colors.white)),
        Text(PrecipitationNullCheck() + "%", style: TextStyle(color: Colors.white)),
        Image.network(widget.weeklyForecast.icon)
      ],
    );
  }

  String GetProperDay(String time) {
    String lowercase = time.toLowerCase();
    if (time == "tonight" || time == "this afternoon" || time == "this morning") {
      return "TOD";
    }
    else return time.substring(0, 3).toUpperCase();
  }

  String PrecipitationNullCheck() {
    if (widget.weeklyForecast.probabilityOfPrecipitation["value"] == null) {
      return "0";
    }
    return widget.weeklyForecast.probabilityOfPrecipitation["value"].toString();
  }

}