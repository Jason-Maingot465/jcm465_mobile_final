import 'package:flutter/material.dart';

class HourlyForecastScreen extends StatefulWidget {
  const HourlyForecastScreen({super.key});

  @override
  State<HourlyForecastScreen> createState() => _HourlyForecastScreenState();
}

class _HourlyForecastScreenState extends State<HourlyForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("Hourly");
  }
}