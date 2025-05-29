import 'dart:convert';

import 'package:weather_app/dtos/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../dtos/response/weather_data.dart';

class WeatherApiClient {
  static Future<WeatherData> getWeatherData(
    double latitude,
    double longitude,
  ) async {
    const API_KEY = UIConstants.WEATHER_API_KEY;
    var url =
        "https://api.weatherapi.com/v1/forecast.json?key=${API_KEY}&q=${latitude},${longitude}&aqi=yes&days=14";
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    final weatherResponse = WeatherData.fromJson(data);
    return weatherResponse;
  }
}
