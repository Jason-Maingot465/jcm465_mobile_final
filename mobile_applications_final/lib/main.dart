import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Map consisting of all NWS stations and their indicators (make sure city names are lower case here)
Map<String, String> stations = {
  "albuquerque": "ABQ",
  "aberdeen": "ABR",
  "anchorage": "AFC",
  "fairbanks": "AFG",
  "juneau": "AJK",
  "wakefield": "AKQ",
  "albany": "ALY",
  "amarillo": "AMA"
};

String stationCode = "";

// Make a network requests
Future<Forecast> fetchCurrentForeCast() async {
  final response = await http.get(
    Uri.parse('https://api.weather.gov/gridpoints/MFL/50,50/forecast')
  );
  if (response.statusCode == 200) {
    return Forecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load forecast');
  }
}

// Class for 12 hour forecasts
class Forecast{

  final int number;
  final String name;
  final String startTime;
  final String endTime;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String temperatureTrend;
  final String windSpeed;
  final String windDirection;
  final String icon;
  final String shortForecast;
  final String detailedForecast;

  const Forecast({
    required this.number,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.temperatureTrend,
    required this.windSpeed,
    required this.windDirection,
    required this.icon,
    required this.shortForecast,
    required this.detailedForecast
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> singleForecast = json["properties"]["periods"][0];
    return switch (singleForecast) {
      {
        'number' : int number,
        'name' : String name,
        'startTime' : String startTime,
        'endTime' : String endTime,
        'isDaytime' : bool isDaytime,
        'temperature': int temperature,
        'temperatureUnit': String temperatureUnit,
        'temperatureTrend' : String temperatureTrend,
        'windSpeed': String windSpeed,
        'windDirection': String windDirection,
        'icon' : String icon,
        'shortForecast': String shortForecast,
        'detailedForecast' : String detailedForecast
      } => Forecast(
        number: number,
        name: name,
        startTime: startTime,
        endTime: endTime,
        isDaytime: isDaytime,
        temperature: temperature,
        temperatureUnit: temperatureUnit,
        temperatureTrend: temperatureTrend,
        windSpeed: windSpeed,
        windDirection: windDirection,
        icon: icon,
        shortForecast: shortForecast,
        detailedForecast: detailedForecast
      ),
      _ => throw const FormatException('Failed to load forecast.')
    };
  }

}

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cityInput = "";
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter City:"),
              onChanged: (String value) {
                cityInput = value;
              },
            ),
            TextButton(
              onPressed: () => {
                setState(() {
                  if (cityInput == "") { // If input is empty
                    errorText = "Please Enter The Name of Your City";
                  } else if (!stations.containsKey(cityInput.toLowerCase())) { // If map doesn't contain city
                    errorText = "$cityInput is not on our list of cities. Please check spelling and try again. If spelling is correct, please try another city near you.";
                  } else { // Map does contain city entered, go onto next page
                    stationCode = stations[cityInput.toLowerCase()]!;
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const ForecastPage();
                    }));
                  }
                })
              }, 
              child: Text("Check Weather")
            ),
            Text("$errorText")
          ],
        ),
      ),
      // body: Center(
      //   child: FutureBuilder(
      //     future: futureForecast, 
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return Text(snapshot.data!.temperature.toString() + snapshot.data!.temperatureUnit + snapshot.data!.windSpeed + snapshot.data!.windDirection + snapshot.data!.shortForecast);
      //       } else if (snapshot.hasError) {
      //         return Text('${snapshot.error}');
      //       }
      //       return const CircularProgressIndicator();
      //     }
      //   ),
      // )
    );
  }
}

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});
  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Forecast> futureForecast;

  @override
  void initState() {
    super.initState();
    futureForecast = fetchCurrentForeCast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(stationCode)
      ),
    );
  }
}