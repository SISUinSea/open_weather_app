part of 'temp_settings_provider.dart';

enum TempUnit { celsis, fahrenheit }

class TempSettingsState extends Equatable {
  TempUnit tempUnit;
  TempSettingsState({
    this.tempUnit = TempUnit.celsis,
  });
  factory TempSettingsState.initial() {
    return TempSettingsState(tempUnit: TempUnit.celsis);
  }
  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
