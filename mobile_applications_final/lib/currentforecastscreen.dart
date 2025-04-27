import 'package:flutter/material.dart';

class CurrentForecastScreen extends StatefulWidget {
  // Vars

  const CurrentForecastScreen({super.key});

  @override
  State<CurrentForecastScreen> createState() => _CurrentForecastScreenState();
}

class _CurrentForecastScreenState extends State<CurrentForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BackButton()
          ],
        ),
        Container(
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Text("miami"),
                Text("73"),
                Text("cloudy")
              ],
            ),
          )
        )
      ]
    );
  }
}