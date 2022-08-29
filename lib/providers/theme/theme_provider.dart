import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:weather_app/constants/constants.dart';

import '../weather/weather_provider.dart';

part 'theme_state.dart';

class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider() : super(ThemeState.initial());

  @override
  void update(Locator watch) {
    // final wp = watch<WeatherState>().weather;
    final weather = watch<WeatherState>().weather;
    if (weather.temp > kWarmOrNot) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }

    super.update(watch);
  }
  // void update(WeatherProvider wp) {
  //   if (wp.state.weather.temp > kWarmOrNot) {
  //     _state = _state.copyWith(appTheme: AppTheme.light);
  //     notifyListeners();
  //   } else {
  //     _state = _state.copyWith(appTheme: AppTheme.dark);
  //     notifyListeners();
  //   }
  // }
}
