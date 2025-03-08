import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService();
  Weather? weather;
  bool isLoading = false;
  double latitude = 24.8607; // Latitude for Karachi
  double longitude = 67.0011; // Longitude for Karachi

  void getWeather() async {
    setState(() => isLoading = true);
    try {
      Weather fetchedWeather = await weatherService.fetchWeather(latitude, longitude);
      setState(() {
        weather = fetchedWeather;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather(); // Fetch weather on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : weather != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'City: ${weather!.city}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Temperature: ${weather!.temp}°C',
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'High: ${weather!.highTemp}°C',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Low: ${weather!.lowTemp}°C',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description: ${weather!.description}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : Text('Failed to load weather', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}