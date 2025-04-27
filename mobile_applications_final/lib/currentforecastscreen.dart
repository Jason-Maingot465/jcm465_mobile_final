import 'package:flutter/material.dart';
import 'package:mobile_applications_final/main.dart';

class CurrentForecastScreen extends StatefulWidget {
  // Variables
  final String cityInput;
  final HourlyForecast currentForecast;

  const CurrentForecastScreen(this.cityInput, this.currentForecast, {super.key});

  @override
  State<CurrentForecastScreen> createState() => _CurrentForecastScreenState();
}

class _CurrentForecastScreenState extends State<CurrentForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(widget.currentForecast.icon), fit: BoxFit.cover),

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
                  ("Current Forecast"),
                  style: TextStyle(fontSize: 24, color: Colors.white)
                )
              ],
            )
          ),
          // Main content
          Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 0,),
                // Temperature Box
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color.fromRGBO(23, 43, 62, .90)),
                  width: 200,
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Text(
                          widget.currentForecast.temperature.toString() + widget.currentForecast.temperatureUnit,
                          style: TextStyle(fontSize: 64, color: Colors.white),
                        ),
                        Text(
                          widget.currentForecast.shortForecast,
                          style: TextStyle(fontSize: 18, color: Colors.white, overflow: TextOverflow.visible,),
                        )
                      ],
                    ),
                  )
                ),
                // Wind and Rain
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Wind Box
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color.fromRGBO(23, 43, 62, .90)),
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Wind", style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 8),
                            Text(widget.currentForecast.windSpeed, style: TextStyle(color: Colors.white, fontSize: 24)),
                            SizedBox(height: 8),
                            Text(widget.currentForecast.windDirection, style: TextStyle(color: Colors.white, fontSize: 18))
                          ],
                        ),
                      )
                    ),
                    // Rain Box
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color.fromRGBO(23, 43, 62, .90)),
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rain", style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 8),
                            Text(widget.currentForecast.probabilityOfPrecipitation["value"].toString() + "%", style: TextStyle(color: Colors.white, fontSize: 24)),
                            SizedBox(height: 8),
                            Text("Chance", style: TextStyle(color: Colors.white, fontSize: 18))
                          ],
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 0,)
              ]
            )
          )
        ]
      )
    );
  }
}