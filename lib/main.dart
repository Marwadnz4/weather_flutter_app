import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(WeatherService()),
      child: MaterialApp(
        theme: ThemeData(
          // scaffoldBackgroundColor: BlocProvider.of<WeatherCubit>(context).weather == null ? Colors.blue : BlocProvider.of<WeatherCubit>(context).weather!.getThemeColor(),
        ),
        home: HomePage(),
      ),
    );
  }
}
