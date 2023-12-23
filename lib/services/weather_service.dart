import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'https://api.openweathermap.org/data/2.5';

  String apiKey = 'd82dc7ccc7310ff285b85ccb8e755ef9';
  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri url =
        Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey');
    http.Response response = await http.get(url);

    if (response.statusCode == 400) {
    var data  = jsonDecode(response.body);
      print(data['error']['message']);
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherModel weather = WeatherModel.fromJson(data);

    return weather;
  }
}
