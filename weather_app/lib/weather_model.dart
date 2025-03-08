import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class Weather {
  Weather(this.city, this.weather, this.mainWeather);

  @JsonKey(name: 'name')
  String city;

  @JsonKey(name: 'weather')
  List<WeatherDescription> weather; // Extract main description from the list

  @JsonKey(name: 'main')
  MainWeather mainWeather; // Map the 'main' object

  String get description => weather.isNotEmpty ? weather[0].main : 'Unknown';

  double get temp => mainWeather.temp;
  double get highTemp => mainWeather.highTemp;
  double get lowTemp => mainWeather.lowTemp;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class WeatherDescription {
  WeatherDescription(this.main, this.description);

  String main;
  String description;

  factory WeatherDescription.fromJson(Map<String, dynamic> json) => _$WeatherDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDescriptionToJson(this);
}

@JsonSerializable()
class MainWeather {
  MainWeather(this.temp, this.highTemp, this.lowTemp);

  @JsonKey(name: 'temp')
  double temp;

  @JsonKey(name: 'temp_max')
  double highTemp;

  @JsonKey(name: 'temp_min')
  double lowTemp;

  factory MainWeather.fromJson(Map<String, dynamic> json) => _$MainWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$MainWeatherToJson(this);
}