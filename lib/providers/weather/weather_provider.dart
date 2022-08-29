import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import '../../models/weather.dart';

part 'weather_state.dart';

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {
  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(status: WeatherStatus.loading);

    try {
      // final Weather weather = await weatherRepository.fetchWeather(city);

      final Weather weather =
          await read<WeatherRepository>().fetchWeather(city);
      state = state.copyWith(status: WeatherStatus.loaded, weather: weather);
      print('state: $state');
    } on CustomError catch (e) {
      state = state.copyWith(error: e, status: WeatherStatus.error);
      print('error state: $state');
    }
  }
}
