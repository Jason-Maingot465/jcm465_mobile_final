import 'package:flutter/material.dart';
import 'package:mobile_applications_final/main.dart';
import 'package:mobile_applications_final/weeklyforecastrow.dart';

class WeeklyForecastScreen extends StatefulWidget {
  // Variables
  final String cityInput;
  final List<WeeklyForecast> weeklyForecasts;

  const WeeklyForecastScreen(this.cityInput, this.weeklyForecasts, {super.key});

  @override
  State<WeeklyForecastScreen> createState() => _WeeklyForecastScreenState();
}

class _WeeklyForecastScreenState extends State<WeeklyForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(widget.weeklyForecasts[0].icon), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          // Backbutton - in row so it is left aligned
          Container(
            color: Color.fromRGBO(23, 43, 62, .90),
            child: Row(
              children: [
                BackButton()
              ],
            ),
          ),
          // Title
          Container(
            color: Color.fromRGBO(23, 43, 62, .90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (widget.cityInput.toUpperCase()),
                  style: TextStyle(fontSize: 48, color: Colors.white)
                )
              ],
            )
          ),
          // Subtitle
          Container(
            color: Color.fromRGBO(23, 43, 62, .90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ("Weekly Forecast"),
                  style: TextStyle(fontSize: 24, color: Colors.white)
                )
              ],
            )
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color.fromRGBO(23, 43, 62, .90)),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    WeeklyForecastRow(widget.weeklyForecasts[0]),
                    WeeklyForecastRow(widget.weeklyForecasts[2]),
                    WeeklyForecastRow(widget.weeklyForecasts[4]),
                    WeeklyForecastRow(widget.weeklyForecasts[6]),
                    WeeklyForecastRow(widget.weeklyForecasts[8]),
                    WeeklyForecastRow(widget.weeklyForecasts[10]),
                    WeeklyForecastRow(widget.weeklyForecasts[12]),
                  ],
                )
              )
            )
          )
        ]
      )
    );
  }
}