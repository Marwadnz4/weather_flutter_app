import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.weatherService) : super(WeatherInitState());

  WeatherService weatherService;


  String? cityName;
  void getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      WeatherModel weather = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccessState(weather: weather));
    } on Exception catch (_) {
      emit(WeatherFailureState());
    }
  }
}
