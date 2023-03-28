import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';
import 'dart:convert';

import 'package:weather_app/models/weathermodel.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String query) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$query&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    return WeatherModel.fromJson(responseJson);
  }
}
