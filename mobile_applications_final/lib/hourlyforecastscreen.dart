import 'package:flutter/material.dart';
import 'package:mobile_applications_final/main.dart';
import 'package:mobile_applications_final/hourlyforecastrow.dart';

class HourlyForecastScreen extends StatefulWidget {
  // Variables
  final String cityInput;
  final List<HourlyForecast> hourlyForecasts;

  const HourlyForecastScreen(this.cityInput, this.hourlyForecasts, {super.key});

  @override
  State<HourlyForecastScreen> createState() => _HourlyForecastScreenState();
}

class _HourlyForecastScreenState extends State<HourlyForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(widget.hourlyForecasts[0].icon), fit: BoxFit.cover),

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
                  ("Hourly Forecast"),
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
                    HourlyForecastRow(widget.hourlyForecasts[0]),
                    HourlyForecastRow(widget.hourlyForecasts[1]),
                    HourlyForecastRow(widget.hourlyForecasts[2]),
                    HourlyForecastRow(widget.hourlyForecasts[3]),
                    HourlyForecastRow(widget.hourlyForecasts[4]),
                    HourlyForecastRow(widget.hourlyForecasts[5]),
                    HourlyForecastRow(widget.hourlyForecasts[6]),
                    HourlyForecastRow(widget.hourlyForecasts[7]),
                    HourlyForecastRow(widget.hourlyForecasts[8]),
                    HourlyForecastRow(widget.hourlyForecasts[9]),
                    HourlyForecastRow(widget.hourlyForecasts[10]),
                    HourlyForecastRow(widget.hourlyForecasts[11]),
                    HourlyForecastRow(widget.hourlyForecasts[12]),
                    HourlyForecastRow(widget.hourlyForecasts[13]),
                    HourlyForecastRow(widget.hourlyForecasts[14]),
                    HourlyForecastRow(widget.hourlyForecasts[15]),
                    HourlyForecastRow(widget.hourlyForecasts[16]),
                    HourlyForecastRow(widget.hourlyForecasts[17]),
                    HourlyForecastRow(widget.hourlyForecasts[18]),
                    HourlyForecastRow(widget.hourlyForecasts[19]),
                    HourlyForecastRow(widget.hourlyForecasts[20]),
                    HourlyForecastRow(widget.hourlyForecasts[21]),
                    HourlyForecastRow(widget.hourlyForecasts[22]),
                    HourlyForecastRow(widget.hourlyForecasts[23]),
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