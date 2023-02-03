import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/constant.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';

part 'theme_state.dart';

class ThemeProvider with ChangeNotifier {
  ThemeState _state = ThemeState.initial();
  ThemeState get state => _state;

  void update(WeatherProvider wp) {
    if (wp.state.weather.temp > kWarmOrNot) {
      _state = _state.copyWith(appTheme: AppTheme.light);
    } else {
      _state = _state.copyWith(appTheme: AppTheme.dark);
    }
    notifyListeners();
  }
}
