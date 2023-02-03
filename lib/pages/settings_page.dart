import 'package:flutter/material.dart';
import 'package:weather_app/providers/temp_settings/temp_settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            ListTile(
              title: Text('Temperature Unit'),
              subtitle: Text('Celsius/Fahrenheit (Default: Celsius)'),
              trailing: Switch(
                value: context.watch<TempSettingsProvider>().state.tempUnit ==
                    TempUnit.celsius,
                onChanged: (value) {
                  context.read<TempSettingsProvider>().toggleTempUnit();
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
