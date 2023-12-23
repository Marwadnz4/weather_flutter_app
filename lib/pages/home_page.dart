import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          WeatherCubit cubit = BlocProvider.of<WeatherCubit>(context);
          if (state is WeatherLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccessState)
            return SuccessBody(
              cubit: cubit,
              weather: state.weather,
            );
          else if (state is WeatherFailureState)
            return const FailureBody();
          else
            return const DefaultHomeBody();
        },
      ),
    );
  }
}

class FailureBody extends StatelessWidget {
  const FailureBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Something went wrong please try again',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class DefaultHomeBody extends StatelessWidget {
  const DefaultHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    super.key,
    required this.weather,
    required this.cubit,
  });

  final WeatherModel weather;
  final WeatherCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //   colors: [],
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            cubit.cityName!,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weather.timezone}:${weather.sys.country}',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                            '${weather.weather[0].icon} ',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                weather.main.temp.toInt().toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp :${weather.main.tempMax}'),
                  Text('minTemp : ${weather.main.tempMin}'),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            weather.base,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
