import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  final WeatherRepository weatherRepository;
  WeatherProvider({
    required this.weatherRepository,
  });

  Future<void> fetchWeather(String city) async {
    _state = _state.copyWith(weatherStatus: WeatherStatus.loading);
    notifyListeners();
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      print('===weather: $weather');
      _state = _state.copyWith(
          weatherStatus: WeatherStatus.loaded, weather: weather);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(weatherStatus: WeatherStatus.error, error: e);
      print('state: $state');
      notifyListeners();
    }
  }
}
