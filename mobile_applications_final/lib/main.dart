import 'currentforecastscreen.dart';
import 'weeklyforecastscreen.dart';
import 'hourlyforecastscreen.dart';
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





// Functions making network requests
Future<List<WeeklyForecast>> fetchWeeklyForeCast(String stationCode, int howMany) async {
  final response = await http.get(
    Uri.parse('https://api.weather.gov/gridpoints/$stationCode/50,50/forecast')
  );
  if (response.statusCode == 200) {
    List<WeeklyForecast> ret = List.empty(growable: true);
    for (int i = 0; i < howMany; i++) {
      ret.add(WeeklyForecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>, i));
    }
    return ret;
  } else {
    throw Exception('Failed to load weekly forecast');
  }
}

Future<List<HourlyForecast>> fetchHourlyForeCast(String stationCode, int howMany) async {
  final response = await http.get(
    Uri.parse('https://api.weather.gov/gridpoints/$stationCode/50,50/forecast/hourly')
  );
  if (response.statusCode == 200) {
    List<HourlyForecast> ret = List.empty(growable: true);
    for (int i = 0; i < howMany; i++) {
      ret.add(HourlyForecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>, i));
    }
    return ret;
  } else {
    throw Exception('Failed to load hourly forecast');
  }
}





// Class to hold data for 12-hour periods
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
      _ => throw const FormatException('Failed to load weekly forecast.')
    };
  }

}

// Class to hold data for hourly periods
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
        windSpeed: windSpeed,
        windDirection: windDirection,
        icon: icon,
        shortForecast: shortForecast,
        detailedForecast: detailedForecast
      ),
      _ => throw const FormatException('Failed to load hourly forecast.')
    };
  }

}





// Starts WeatherApp on run
void main() {
  runApp(const WeatherApp());
}



// WeatherApp
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


// Home page state: gets city and looks up correct abreviation for URL for network requests
class _MyHomePageState extends State<MyHomePage> {
  String cityInput = "";
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.deepOrange,
      ),
      // Body
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
            // Button to submit city name, and either give error or move to next page with relavent data
            TextButton(
              onPressed: () => {
                setState(() {
                  if (cityInput == "") { // If input is empty ask for input
                    errorText = "Please Enter The Name of Your City";
                  } else if (!stations.containsKey(cityInput.toLowerCase())) { // If map doesn't contain city ask to check spelling or try different city
                    errorText = "$cityInput is not on our list of cities. Please check spelling and try again. If spelling is correct, please try another city near you.";
                  } else { // Map does contain city entered, go onto next page with station abreviation for URL
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ForecastPage(stationCode: stations[cityInput.toLowerCase()]!),
                    ));
                  }
                })
              }, 
              child: Text("Check Weather")
            ),
            // Shows error text if there is any
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

// Forecast page state
class _ForecastPageState extends State<ForecastPage> {
  // index of which tab user is on
  int currentIndex = 0;

  // Lists of weekly and hourly forecast from NWS API
  late Future<List<WeeklyForecast>> futureWeeklyForecasts;
  late Future<List<HourlyForecast>> futureHourlyForecasts;

  // Gets forecast lists on initialize
  @override
  void initState() {
    super.initState();
    futureHourlyForecasts = fetchHourlyForeCast(widget.stationCode, 1);
    futureWeeklyForecasts = fetchWeeklyForeCast(widget.stationCode, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uses future builder in case future widget variable hasn't been given a value yet
      body: <Widget>[
        FutureBuilder(
          future: futureHourlyForecasts, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CurrentForecastScreen();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
        FutureBuilder(
          future: futureHourlyForecasts, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HourlyForecastScreen();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
        FutureBuilder(
          future: futureWeeklyForecasts, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeeklyForecastScreen();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ][currentIndex],
      // Navigation bar for changing tabs
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Icons.wb_cloudy_outlined), 
            label: "Current Weather"
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined), 
            label: "Hourly Forecast"
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined), 
            label: "Weekly Forecast"
          ),
        ],
        selectedIndex: currentIndex,
      ),
    );
  }
}