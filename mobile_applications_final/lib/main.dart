import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Map consisting of all NWS stations and their indicators (make sure city names are lower case here, added state if there are duplicate names)
Map<String, String> stations = {
  "albuquerque": "ABQ",
  "aberdeen": "ABR",
  "anchorage": "AFC",
  "fairbanks": "AFG",
  "juneau": "AJK",
  "wakefield": "AKQ",
  "albany": "ALY",
  "amarillo": "AMA",
  "gaylord" : "APX",
  "la crosse": "ARX",
  "binghampton": "BGM",
  "bismark": "BIS",
  "birmingham": "BMX",
  "boise": "BOI",
  "denver": "BOU",
  "boulder": "BOU",
  "boston": "BOX",
  "brownsville": "BRO",
  "burlington": "BTV",
  "buffalo": "BUF",
  "billings": "BYZ",
  "columbia": "CAE",
  "caribou": "CAR",
  "charleston, sc": "CHS",
  "cleveland": "CLE",
  "corpus christi": "CRP",
  "central pennsylvania": "CTP",
  "cheyenne": "CYS",
  "dodge city": "DDC",
  "duluth": "DLH",
  "des moines": "DMX",
  "detroit": "DTX",
  "quad cities": "DVN",
  "kansas city": "EAX",
  "eureka": "EKA",
  "el paso": "EPZ",
  "key west": "EYW",
  "austin": "EWX",
  "san antonio": "EWX",
  "atlanta": "FFC",
  "grand forks": "FGF",
  "flagstaff": "FGZ",
  "sioux falls": "FSD",
  "dallas": "FWD",
  "fort worth": "FWD",
  "glasgow": "GGW",
  "hastings": "GID",
  "grand junction": "GJT",
  "goodland": "GLD",
  "green bay": "GRB",
  "grand rapids": "GRR",
  "greenville": "GSP",
  "spartanburg": "GSP",
  "guam": "GUA",
  "portland, me": "GYX",
  "honolulu": "HFO",
  "houston": "HGX",
  "galveston": "HGX",
  "san joaquin valley": "HNX",
  "wichita": "ICT",
  "wilmington": "ILM",
  "cincinnati": "ILN",
  "central illinois": "ILX",
  "lincoln": "ILX",
  "indianapolis": "IND",
  "syracuse": "IWX",
  "jackson, ms": "JAN",
  "jacksonville": "JAX",
  "jackson, ky": "JKL",
  "north platte": "LBF",
  "lake charles": "LCH",
  "new orleans": "LIX",
  "baton rouge": "LIX",
  "elko": "LKN",
  "louisville": "LMK",
  "chicago": "LOT",
  "los angeles": "LOX",
  "st louis": "LSX",
  "lubbock": "LUB",
  "baltimore": "LWX",
  "washington dc": "LWX",
  "little rock": "LZK",
  "midland": "MAF",
  "odessa": "MAF",
  "memphis": "MEG",
  "miami": "MFL",
  "medford": "MFR",
  "morehead": "MHX",
  "milwaukee": "MKX",
  "melbourne": "MLB",
  "mobile": "MOB",
  "minneapolis": "MPX",
  "marquette": "MQT",
  "knoxville": "MRX",
  "missoula": "MSO",
  "san francisco": "MTR",
  "omaha": "OAX",
  "nashville": "OHX",
  "new york city": "OKX",
  "spokane": "OTX",
  "oklahoma city": "OUN",
  "paducah": "PAH",
  "pittsburgh": "PBZ",
  "pendleton": "PDT",
  "philidelphia": "PHI",
  "pocatello": "PIH",
  "portland, or": "PQR",
  "phoenix": "PSR",
  "pueblo": "PUB",
  "raleigh": "RAH",
  "reno": "REV",
  "riverton": "RIW",
  "charleston, wv": "RLX",
  "roanoke": "RNK",
  "seattle": "SEW",
  "springfield": "SGF",
  "san diego": "SGX",
  "shreveport": "SHV",
  "san angelo": "SJT",
  "san juan": "SJU",
  "salt lake city": "SLC",
  "sacramento": "STO",
  "tallahassee": "TAE",
  "tampa": "TBW",
  "great falls": "TFX",
  "topeka": "TOP",
  "tulsa": "TSA",
  "tucson": "TWC",
  "rapid city": "UNR",
  "las vegas": "VEF"
};

// Make network requests
Future<WeeklyForecast> fetchWeeklyForeCast(String stationCode, int index) async {
  final response = await http.get(
    Uri.parse('https://api.weather.gov/gridpoints/$stationCode/50,50/forecast')
  );
  if (response.statusCode == 200) {
    return WeeklyForecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>, index);
  } else {
    throw Exception('Failed to load weekly forecast');
  }
}

Future<HourlyForecast> fetchHourlyForeCast(String stationCode, int index) async {
  final response = await http.get(
    Uri.parse('https://api.weather.gov/gridpoints/$stationCode/50,50/forecast/hourly')
  );
  if (response.statusCode == 200) {
    return HourlyForecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>, index);
  } else {
    throw Exception('Failed to load hourly forecast');
  }
}


// Class for 12 hour weekly forecasts
class WeeklyForecast{

  final int number;
  final String name;
  final String startTime;
  final String endTime;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String temperatureTrend;
  final Map<String, dynamic> probabilityOfPrecipitation;
  final String windSpeed;
  final String windDirection;
  final String icon;
  final String shortForecast;
  final String detailedForecast;

  const WeeklyForecast({
    required this.number,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.temperatureTrend,
    required this.probabilityOfPrecipitation,
    required this.windSpeed,
    required this.windDirection,
    required this.icon,
    required this.shortForecast,
    required this.detailedForecast
  });

  factory WeeklyForecast.fromJson(Map<String, dynamic> json, int index) {
    Map<String, dynamic> singleForecast = json["properties"]["periods"][index];
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
        'probabilityOfPrecipitation' : Map<String, dynamic> probabilityOfPrecipitation,
        'windSpeed': String windSpeed,
        'windDirection': String windDirection,
        'icon' : String icon,
        'shortForecast': String shortForecast,
        'detailedForecast' : String detailedForecast
      } => WeeklyForecast(
        number: number,
        name: name,
        startTime: startTime,
        endTime: endTime,
        isDaytime: isDaytime,
        temperature: temperature,
        temperatureUnit: temperatureUnit,
        temperatureTrend: temperatureTrend,
        probabilityOfPrecipitation: probabilityOfPrecipitation,
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

// Class for hourly forcast
class HourlyForecast{
  
  final int number;
  final String name;
  final String startTime;
  final String endTime;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String temperatureTrend;
  final Map<String, dynamic> probabilityOfPrecipitation;
  final Map<String, dynamic> dewpoint;
  final Map<String, dynamic> relativeHumudity;
  final String windSpeed;
  final String windDirection;
  final String icon;
  final String shortForecast;
  final String detailedForecast;

  const HourlyForecast({
    required this.number,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.temperatureTrend,
    required this.probabilityOfPrecipitation,
    required this.dewpoint,
    required this.relativeHumudity,
    required this.windSpeed,
    required this.windDirection,
    required this.icon,
    required this.shortForecast,
    required this.detailedForecast
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json, int index) {
    Map<String, dynamic> singleForecast = json["properties"]["periods"][index];
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
        'probabilityOfPrecipitation' : Map<String, dynamic> probabilityOfPrecipitation,
        'dewpoint' : Map<String, dynamic> dewpoint,
        'relativeHumudity' : Map<String, dynamic> relativeHumudity,
        'windSpeed': String windSpeed,
        'windDirection': String windDirection,
        'icon' : String icon,
        'shortForecast': String shortForecast,
        'detailedForecast' : String detailedForecast
      } => HourlyForecast(
        number: number,
        name: name,
        startTime: startTime,
        endTime: endTime,
        isDaytime: isDaytime,
        temperature: temperature,
        temperatureUnit: temperatureUnit,
        temperatureTrend: temperatureTrend,
        probabilityOfPrecipitation: probabilityOfPrecipitation,
        dewpoint: dewpoint,
        relativeHumudity: relativeHumudity,
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

// Starts app on run
void main() {
  runApp(const WeatherApp());
}

// App starts on MyHomePage, with title of 'Weather App'
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: const MyHomePage(),
    );
  }
}

// Home page
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
            // Text field to get city name, store input in 'cityInput' variable
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ForecastPage(stationCode: stations[cityInput.toLowerCase()]!),
                    ));
                  }
                })
              }, 
              child: Text("Check Weather")
            ),
            Text("$errorText")
          ],
        ),
      ),
    );
  }
}

// Page that shows all of the forcasts
class ForecastPage extends StatefulWidget {
  final String stationCode;
  const ForecastPage({Key? key, required this.stationCode}) : super(key: key);
  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<WeeklyForecast> futureWeeklyForecast;
  late Future<HourlyForecast> futureHourlyForecast;

  @override
  void initState() {
    super.initState();
    futureWeeklyForecast = fetchWeeklyForeCast(widget.stationCode, 0);
    futureHourlyForecast = fetchHourlyForeCast(widget.stationCode, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futureWeeklyForecast, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.network(snapshot.data!.icon),
                  Text("Temperature: " + snapshot.data!.temperature.toString() + " " + snapshot.data!.temperatureUnit),
                  Text("Wind: " + snapshot.data!.windSpeed + " " + snapshot.data!.windDirection),
                  Text("Forecast: " + snapshot.data!.shortForecast)
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}