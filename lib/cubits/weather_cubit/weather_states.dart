// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/models/weather_model.dart';

abstract class WeatherStates {}

class WeatherInitState extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {}

class WeatherSuccessState extends WeatherStates {
    final WeatherModel weather;
  WeatherSuccessState({
    required this.weather
  });
}

class WeatherFailureState extends WeatherStates {}
