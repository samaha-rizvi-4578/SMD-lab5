import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart'; // Import model properly

class WeatherService {
  static const String apiKey = '0df705e4384e6c1fe7fd4419f6dbe972'; // Replace with your API key
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

// void main() async {
//   WeatherService weatherService = WeatherService();
//   try {
//     Weather weather = await weatherService.fetchWeather(24.8607, 67.0011);
//     print('City: ${weather.city}');
//     print('Description: ${weather.description}');
//     print('Temperature: ${weather.temp}');
//     print('High Temp: ${weather.highTemp}');
//     print('Low Temp: ${weather.lowTemp}');
//   } catch (e) {
//     print(e);
//   }
// }