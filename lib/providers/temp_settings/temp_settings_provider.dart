import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'temp_settings_state.dart';

class TempSettingsProvider with ChangeNotifier {
  TempSettingsState _state = TempSettingsState.initial();
  TempSettingsState get state => _state;

  void toggleTempUnit() {
    _state = _state.copyWith(
        tempUnit: _state.tempUnit == TempUnit.celsis
            ? TempUnit.fahrenheit
            : TempUnit.celsis);
    print('temp unit: $_state');
    notifyListeners();
  }
}