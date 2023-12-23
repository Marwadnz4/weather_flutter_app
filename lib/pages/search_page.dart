import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              WeatherCubit cubit = BlocProvider.of<WeatherCubit>(context);
              cubit.getWeather(cityName: cityName!);
              cubit.cityName = cityName!;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: const Text('search'),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherCubit cubit = BlocProvider.of<WeatherCubit>(context);
                    cubit.getWeather(cityName: cityName!);
                    cubit.cityName = cityName!;
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
              border: const OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}
