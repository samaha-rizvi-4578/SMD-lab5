// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['name'] as String,
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
      MainWeather.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'name': instance.city,
      'weather': instance.weather,
      'main': instance.mainWeather,
    };

WeatherDescription _$WeatherDescriptionFromJson(Map<String, dynamic> json) =>
    WeatherDescription(
      json['main'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$WeatherDescriptionToJson(WeatherDescription instance) =>
    <String, dynamic>{
      'main': instance.main,
      'description': instance.description,
    };

MainWeather _$MainWeatherFromJson(Map<String, dynamic> json) => MainWeather(
      (json['temp'] as num).toDouble(),
      (json['temp_max'] as num).toDouble(),
      (json['temp_min'] as num).toDouble(),
    );

Map<String, dynamic> _$MainWeatherToJson(MainWeather instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'temp_max': instance.highTemp,
      'temp_min': instance.lowTemp,
    };
